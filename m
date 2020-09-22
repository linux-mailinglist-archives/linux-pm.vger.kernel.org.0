Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C505D2745CB
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVPw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 11:52:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42264 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIVPw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 11:52:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so11582619otl.9
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2020 08:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3q9f14ehpAz5FVsFd+k/aiAvb/GxFKUaV2cgid0foQ=;
        b=ViJAuS48Zt79m25VIiI8Rl9G0cxmHibZlhBIPPV/X2cJaR0U6ya+xs6ne8HcWLKHQa
         iI2jL1IOB8K9uPy0DWSdgRcee17TTasEyiks8er8LYnB+LeKqAKfMS+f3UIH07XkDbzG
         4xPkQDce6EJCpOE/94CYFboYCKuk2tHcG7fdhWDePgx2q18lhouNAJh1WHmcLDwiVJaY
         PcXg3Any3Dx+65BcJfUjnryFN/eIvoeYSIcaSUyJfbl0AVPRAvaLgX+xG+wVnVyxKooq
         Pvc/9oqQLmZ7fmNHHmV1GCcbZyZMKqWaNs5uoEyu3FUT3KBAAhYWzze6EuNP2on7I280
         pa+A==
X-Gm-Message-State: AOAM533VOYuKLlueGPfD/Yg5SP+KLE+wLsBEdSTrh09m8EAa4IJF72nO
        fITOZO7HMe2uy9e0xMb7jYtKZhuwumorgq5/hRE=
X-Google-Smtp-Source: ABdhPJwwnquJiS4Bglp8qZNaDx5i6oFUEt6soBVGViBRA2vNmVhgxHRoVIwsU9dj/Ykj+RsebZqCZAOBOtvc5iHFEvw=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr3047075otp.167.1600789977850;
 Tue, 22 Sep 2020 08:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142859.224381-1-ulf.hansson@linaro.org> <CAPDyKFrim8D10N46FFE55kuWw68SuRWBD3HBcY5VMkOR1fhybg@mail.gmail.com>
In-Reply-To: <CAPDyKFrim8D10N46FFE55kuWw68SuRWBD3HBcY5VMkOR1fhybg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 17:52:46 +0200
Message-ID: <CAJZ5v0i6myhZfb6GTSUdyWXYqAhc2RGBotDit+0UPzjrzRxWSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cpuidle: psci: Always create the PM domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 9:51 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 1 Sep 2020 at 16:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > This coverletter is mainly to help keeping track of the patches part in the
> > series. Please have a look at each patch for more details.
> >
> > Kind regards
> > Ulf Hansson
> >
> >
> > Ulf Hansson (2):
> >   firmware: psci: Extend psci_set_osi_mode() to allow reset to PC mode
> >   cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
> >
> >  drivers/cpuidle/cpuidle-psci-domain.c | 59 ++++++++++++++-------------
> >  drivers/firmware/psci/psci.c          | 12 +++---
> >  include/linux/psci.h                  |  2 +-
> >  3 files changed, 39 insertions(+), 34 deletions(-)
> >
>
> Rafael, I guess you may have not seen this one.

I have seen it, but I didn't manage to get to it before today, sadly.

> I think it's ready to get applied as v5.10 material. Do you want me to resend?

No need, applied now.

Thanks!
