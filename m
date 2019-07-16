Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351156AF97
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 21:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfGPTM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 15:12:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37614 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPTM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 15:12:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so16512988oih.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EokRdVtnqINNMeRei8g3SJejrlpwhuP/sBz4PdO769o=;
        b=kkXFYQ4BGd2rPaOJss3nxEly+aTRCXPtLhXjo2jX0eHJ0gYk/NfDhYxZt2dbZDt7V/
         Ht9777mnN/JK5uMBe+N50bVXOZEgNz70p1lOWFa86DgeLODas1wW/TEAgBZ+10rmXVg7
         Wl/NA9vC9K+q6hvr5XobK72vptUqBgmytGGAd428TKu6DfFHTGZayCL78o9cxwCMcMZf
         KlCGJ1JfJ09UmfweNDAr/6G8rs5OsBrYixKRVgQE6fURLsnUsOOcZ3iNAIAdA6EnsXeL
         /QkLWj8uHiKK+O5D8RMtOmWM36Sm6GFsXhUA4HhPQWKV57lR6L3ki6Dt26//2+TGwB1i
         g6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EokRdVtnqINNMeRei8g3SJejrlpwhuP/sBz4PdO769o=;
        b=PMGStqThuYSgxfAaSxV0GCOhdaemE/xtlqNG3usD/vLFamjWZuwLdwVx+OmhPu74PX
         oZFymU6BuS/J6iAj0QVGMFc/mUi6m0meQ4Xft63+Jp08bHKhGiD844NY/sZZVjQ0v9sa
         hwvxBOpSfuV530iAxl84phqGs9NEvBkcdRMu/FIzThD4Zl1WDkpegzSoyITb2TTgDSFT
         7ZBYYN8eYeRhMLILkPFI74GE6SDHGsTjEbhvxX20dxyVGoL4nQe1Echqs89v6+hJHbMK
         gkwoyMAxdQ91sIPmKDJTyFcjBxH2KNrWaEMSG/lXf+KnU/lb3w2f4zsQo9Y+JtGo/XmD
         gEag==
X-Gm-Message-State: APjAAAXkJA01NPvTVWZQN6FwdG0eUHJHeeRvz/3Vro5bKSgOAq0wVxw3
        zklbmHfhHlxhq08BExO+3ZC3pGfuNqv7GQEkXEZpYw==
X-Google-Smtp-Source: APXvYqzvI0Zhyn3SPjXH+FWy4nFoerSYx7E3aeJUm3+PDLU+ilI3ejmzk8U7vgvbRvDquPXrT1qJZqgYVUwbzn5z0iI=
X-Received: by 2002:aca:e641:: with SMTP id d62mr17288062oih.24.1563304376244;
 Tue, 16 Jul 2019 12:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com> <20190625213337.157525-4-saravanak@google.com>
 <e9c9b150-43a6-dc6b-5d88-21608120e940@codeaurora.org>
In-Reply-To: <e9c9b150-43a6-dc6b-5d88-21608120e940@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Jul 2019 12:12:20 -0700
Message-ID: <CAGETcx8K3Z65Ru6dytbaJUm3xfWT8RxjKy788BAmksxS50YZqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM / devfreq: Cache OPP table reference in devfreq
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 10:36 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Hey Saravana,
>
> On 6/26/19 3:03 AM, Saravana Kannan wrote:
> > The OPP table can be used often in devfreq. Trying to get it each time can
> > be expensive, so cache it in the devfreq struct.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >   drivers/devfreq/devfreq.c | 6 ++++++
> >   include/linux/devfreq.h   | 1 +
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 6b6991f0e873..ac62b78dc035 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -597,6 +597,8 @@ static void devfreq_dev_release(struct device *dev)
> >       if (devfreq->profile->exit)
> >               devfreq->profile->exit(devfreq->dev.parent);
> >
> > +     if (devfreq->opp_table)
> > +             dev_pm_opp_put_opp_table(devfreq->opp_table);
> >       mutex_destroy(&devfreq->lock);
> >       kfree(devfreq);
> >   }
> > @@ -677,6 +679,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >       devfreq->max_freq = devfreq->scaling_max_freq;
> >
> >       devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> > +     devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
> > +     if (IS_ERR(devfreq->opp_table))
> > +             devfreq->opp_table = NULL;
> > +
> >       atomic_set(&devfreq->suspend_count, 0);
> >
> >       dev_set_name(&devfreq->dev, "devfreq%d",
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index fbffa74bfc1b..0d877c9513d7 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -156,6 +156,7 @@ struct devfreq {
> >       struct devfreq_dev_profile *profile;
> >       const struct devfreq_governor *governor;
> >       char governor_name[DEVFREQ_NAME_LEN];
> > +     struct opp_table *opp_table;
>
> please add it to the function docs as well

Will do.

-Saravana
