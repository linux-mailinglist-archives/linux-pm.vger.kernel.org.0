Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55D23A36A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHCLi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 07:38:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38286 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCLhI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 07:37:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id q9so11986557oth.5;
        Mon, 03 Aug 2020 04:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nvENeSXjDTJ1ixr/A+p7Tzhs+JxqY29ttHHyb6V5/s=;
        b=FPJuum4OWRZgLhZRynw0z1KUthlLL13OLiMocHS6aazW2wRCxa4/S+M6/0QbJ1jMw5
         B920uDc7Oow+eunxOk+mVBGdnFHcMJ9nKIY1jHwFK5Eez03qHKEfcZOgQyVnnuLS04kN
         C1dyRgy8usiYijwF9Z4nN0M5vcKKNWESm7yvpbS+l3NwkLBWZNFoHZRcU7gzPM2eNe58
         D8Ddvr1D74tGedf2bI84rpq8xdElpjkLmvLuldPU8lGXUXLO3R9mptPgSuDYVt+kA4ul
         EKagE9bWonI9uBG1y9b4+myGUXkLVhFR49VofCacrimaCSi8KyAFvDO9qxVngjPK6nZM
         U+Kw==
X-Gm-Message-State: AOAM533EWNJWcOYzPEMmop+xif6B6E05XTTLTCqMeMtxEQpbqpvpP1bB
        IofGyIcQQAHw/DSb6Gq6tav0oyqDyEfZ5iTY94WVG5cq
X-Google-Smtp-Source: ABdhPJy1gO8YR7YhjbNf4BGWEQg9zoUoZNKtB8AS1uO9D3Fu/RvP2a7H2BExLyzmvqxgi65Xr2S719nOguAwN6KYTh4=
X-Received: by 2002:a05:6830:1c74:: with SMTP id s20mr12674907otg.167.1596454627644;
 Mon, 03 Aug 2020 04:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <2672940.cHDmkauF2A@kreacher> <20200803085347.GV13316@paasikivi.fi.intel.com>
In-Reply-To: <20200803085347.GV13316@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Aug 2020 13:36:52 +0200
Message-ID: <CAJZ5v0hRi3DZ69b1b=xes4qz2keq_aGDzX5kKQsR_rkwuFgk0w@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Add kerneldoc comments to multiple helpers
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sakari,

On Mon, Aug 3, 2020 at 10:53 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the patch.
>
> On Fri, Jul 31, 2020 at 07:03:26PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add kerneldoc comments to multiple PM-runtime helper functions
> > defined as static inline wrappers around lower-level routines to
> > provide quick reference decumentation of their behavior.
>
> > Some of them are similar to each other with subtle differences only
> > and the behavior of some of them may appear as counter-intuitive, so
> > clarify all that to avoid confusion.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/linux/pm_runtime.h |  246 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 246 insertions(+)
> >
> > Index: linux-pm/include/linux/pm_runtime.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/pm_runtime.h
> > +++ linux-pm/include/linux/pm_runtime.h
> > @@ -60,58 +60,151 @@ extern void pm_runtime_put_suppliers(str
> >  extern void pm_runtime_new_link(struct device *dev);
> >  extern void pm_runtime_drop_link(struct device *dev);
> >
> > +/**
> > + * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
> > + * @dev: Target device.
> > + *
> > + * Increment the runtime PM usage counter of @dev if its runtime PM status is
> > + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0.
>
> The implementation of the non-runtime PM variants (used when CONFIG_PM is
> disabled) isn't here but I think it'd be nice if their behaviour was also
> documented here. pm_runtime_get_if_in_use() returns -EINVAL if CONFIG_PM is
> disabled, for instance.

These kerneldoc comments cover the CONFIG_PM case only.  The behavior
for !CONFIG_PM needs to be figured out from the code, if it matters.

I'm not sure why it would matter for pm_runtime_get_if_in_use(), in particular?

> pm_runtime_disable() is defined here but the documentation in corresponding
> pm_runtime_enable() in drivers/base/power/runtime.c is rather terse. It'd
> be nice to improve that now (or separately).

Yes, separately.

Thanks!
