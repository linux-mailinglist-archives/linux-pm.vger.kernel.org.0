Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79FFAD5E8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 11:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfIIJlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 05:41:17 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34729 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfIIJlR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 05:41:17 -0400
Received: by mail-ua1-f66.google.com with SMTP id f25so4058164uap.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2019 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PuR1fcbJUiP6C3dnIS8EHaZBW3jUZPzLiy9Fdrqco4=;
        b=jR6QDvR4q57Nli9dhXOVNkp77JY04qG/jULe56aBAb06+Epck8OR2qd5H6gmbEJ9SG
         tkOpHu3/zvG2quV+pKM9FlATYU5YSaewjfqRrRouTmxtHssSV5nQ/Ol35zvYkVUyezXz
         60cFb2P4TCJ1Fx+bnljCoR6cRSvMuYdWh4dZSDZjsg+PKnKMWajbhhz5WupBfNwmChVO
         lslX+MCyo3BPO+QKMqYaamW4EpGC2uYVcCuT10yQQ1fMhiPPQf3AB+ree4Xo7EovCC2U
         aKNxwVzCCphiQyj1TY/pCOxpE0efbJsrUsM6KNdl+dczi0IyQir7xzAG2O7xSxSKihzy
         F4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PuR1fcbJUiP6C3dnIS8EHaZBW3jUZPzLiy9Fdrqco4=;
        b=hfAoda+ZzsutK9pHCIjLbmShuL8IrpziAtVMZ5pcMDfg1snwz+aJzEMe53hkC1xwwr
         gZK8vX9oI25irJ+6/lZn8dAVt32rqeaKPHBss1BxRsxqrHJJcawYsSxbIJtAHfhU7Nt/
         vQGvNjm9ihlLhl27UHPH6GP1p+0yRY3cixH86cDLBB4YnZ71Wwyb4tHBLDQWV5LdiHuu
         bYqeNFZvBTgbJ14XE+dPhtdC2U55y3dpY1fb4hnM0lWPtqm31uBJztV9IeW145n5HYtb
         NqkPSH5fvHdO5JdsRBfluBo6vi/5s1IWU05JWjFqdz50UC2DSHLyuKPBptCAMmUodpSW
         eesw==
X-Gm-Message-State: APjAAAWsBPkL+75wHhaRPDKbnv/dxqtccBY2s+msugnlbvxvjU7DAs3/
        1xfhN48YoEey+9ahmAImEbdlmjbUoYrwx4s25oB8AQ==
X-Google-Smtp-Source: APXvYqxvtxq537xBknY78F5hjndWmAwtKqtvACJnUmpi4lvz08hFIHcUupwoDfa89KGdyO/HzUC7WtGn1IYhNopOLw4=
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr4001029uar.104.1568022074856;
 Mon, 09 Sep 2019 02:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFrcK+Jub0gAeevrscoGaHA+PRGmVHZHxB2T6_3Fqm=ceA@mail.gmail.com> <5D72DC94.6040508@linaro.org>
In-Reply-To: <5D72DC94.6040508@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Sep 2019 11:40:37 +0200
Message-ID: <CAPDyKFqXYCK1bMFHmdNyOp1VwTopJ8gTHCBL1FajOS8LY+MoPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM/Domains: Add support for retrieving genpd
 performance states information
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     qualcomm-lt@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 7 Sep 2019 at 00:24, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> On 08/22/2019 11:03 AM, Ulf Hansson wrote:
> > On Sat, 10 Aug 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> >>
> >> Add two new APIs in the genpd framework,
> >> dev_pm_genpd_get_performance_state to return the current performance
> >> state of a power domain and dev_pm_genpd_performance_state_count to
> >> return the total number of performance states supported by a
> >> power domain. Since the genpd framework does not maintain
> >> a count of number of performance states supported by a power domain,
> >> introduce a new callback(.get_performance_state_count) that can be used
> >> to retrieve this information from power domain drivers.
> >
> > I think some brief background to *why* this is useful needs to be
> > squeezed into the changelog. Or at least state that following changes
> > makes use of it, somehow.
> >
> >>
> >> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >> ---
> >>  drivers/base/power/domain.c | 38 ++++++++++++++++++++++++++++++++++++++
> >>  include/linux/pm_domain.h   | 18 ++++++++++++++++++
> >>  2 files changed, 56 insertions(+)
> >>
> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >> index b063bc4..17e0375 100644
> >> --- a/drivers/base/power/domain.c
> >> +++ b/drivers/base/power/domain.c
> >> @@ -413,6 +413,44 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >>  }
> >>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
> >>
> >> +int dev_pm_genpd_get_performance_state(struct device *dev,
> >> +                                      unsigned int *state)
> >> +{
> >> +       struct generic_pm_domain *genpd;
> >> +
> >> +       genpd = dev_to_genpd(dev);
> >
> > We need to verify that the there is a genpd attached before doing this
> > cast. Let me post a patch in a day or so, it will give you a helper
> > function that covers this.
> >
> >> +       if (IS_ERR(genpd))
> >> +               return -ENODEV;
> >> +
> >> +       genpd_lock(genpd);
> >> +       *state = genpd->performance_state;
> >
> > Why not return the state, rather than assigning an out-parameter?
> >
> >> +       genpd_unlock(genpd);
> >> +
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
> >> +
> >> +int dev_pm_genpd_performance_state_count(struct device *dev,
> >> +                                        unsigned int *count)
> >> +{
> >> +       struct generic_pm_domain *genpd;
> >> +       int ret;
> >> +
> >> +       genpd = dev_to_genpd(dev);
> >> +       if (IS_ERR(genpd))
> >> +               return -ENODEV;
> >> +
> >> +       if (unlikely(!genpd->get_performance_state_count))
> >> +               return -EINVAL;
> >> +
> >> +       genpd_lock(genpd);
> >> +       ret = genpd->get_performance_state_count(genpd, count);
> >
> > Why not having the callback to return the state, rather than using an
> > out-parameter?
> Hi Ulf,
> I just realized that returning the state instead of using a parameter
> will prevent me from access under lock. Is that okay ?

Not sure I understand. Why can't you just assign a local variable and
return that?

Like this:

genpd_lock();
count = genpd->get_performance_state_count();
genpd_unlock();

return count;

[...]

Kind regards
Uffe
