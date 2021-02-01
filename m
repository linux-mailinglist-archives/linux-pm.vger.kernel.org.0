Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1022A30A957
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 15:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhBAOGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 09:06:45 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:38047 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhBAOGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 09:06:33 -0500
Received: by mail-oi1-f170.google.com with SMTP id h6so18877425oie.5;
        Mon, 01 Feb 2021 06:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SzpemPQB+/TRnRzTNJla8BM75IUCXAeWcKUwN4Y6ms=;
        b=G/0ur6JrGubFYU5Au+iQKd2fpKUmRFCKN19qC3LlpnsSVXrOatoqe5a9hnjSnqgZD8
         6J/vj8/mfEnI1RIQnBKjISk1ykauLIvCbcaxmco09P4CfToy+fuyQrbvJqqr4piaOmCU
         6D9xdc8I+i+IUBrR+VBJ5gUGZIXX2SydZJcLj69CY7+cEEJK9Tj+P3CRuZf4eT/l46OL
         9CmqqXoNBFSZOPZYIDZlrtc74uuUZFoW5A7pdxF/P5ZxoV/Cg5H5ds/6enEehDTfXbMs
         mj47/6LOsU/QK1wiNbGhSrb7tIp1SeL0Hf5KQOAyYpgCpeJIWHjvJgRIhEZS8Cz1jNrt
         4+UQ==
X-Gm-Message-State: AOAM5334JVeZLvk2k/knabhRf6Orn4b1saA8q7xpqP/MvQoriSN4C89r
        r50Vn89zBTkWL6tfSVn00VPq13/gej+jtWrmznY=
X-Google-Smtp-Source: ABdhPJwJB9jBNuY8JgwpRFRdK2Bkqgl8TxJR/6j+4AlzXXofvePOK74g45qZiRTctcZ/Pf1S+BE6Cbq+UFbObKydWys=
X-Received: by 2002:aca:d14:: with SMTP id 20mr11411887oin.157.1612188353137;
 Mon, 01 Feb 2021 06:05:53 -0800 (PST)
MIME-Version: 1.0
References: <1611736925-32547-1-git-send-email-abaci-bugfix@linux.alibaba.com> <CAPDyKFrtwFwPjLz7OYOtF4S7WORoyGFgpv9n6xABn-vp3w59dQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrtwFwPjLz7OYOtF4S7WORoyGFgpv9n6xABn-vp3w59dQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 15:05:42 +0100
Message-ID: <CAJZ5v0h_=Wm_nSNFj_s4+16y3rW0OMzTxNQ=GbUNUfpqYy=EXA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Simplify the calculation of variables
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 1, 2021 at 11:11 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 27 Jan 2021 at 09:42, Abaci Team <abaci-bugfix@linux.alibaba.com> wrote:
> >
> > Fix the following coccicheck warnings:
> >
> > ./drivers/base/power/domain.c:938:31-33: WARNING !A || A && B is
> > equivalent to !A || B.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> > Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.12 material, thanks!

> > ---
> >  drivers/base/power/domain.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 9a14eed..e689710 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -934,8 +934,7 @@ static int genpd_runtime_resume(struct device *dev)
> >  err_stop:
> >         genpd_stop_dev(genpd, dev);
> >  err_poweroff:
> > -       if (!pm_runtime_is_irq_safe(dev) ||
> > -               (pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
> > +       if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
> >                 genpd_lock(genpd);
> >                 genpd_power_off(genpd, true, 0);
> >                 genpd_unlock(genpd);
> > --
> > 1.8.3.1
> >
