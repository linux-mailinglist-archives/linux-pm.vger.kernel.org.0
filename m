Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30443106F1
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEAKYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:24:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62132 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:24:31 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 2b44ea8a5b6b638e; Wed, 1 May 2019 12:24:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / Domains: remove unnecessary unlikely()
Date:   Wed, 01 May 2019 12:24:29 +0200
Message-ID: <4341173.rtllOHV0ML@kreacher>
In-Reply-To: <CAPDyKFpR6bwjUG_WtgvXJznBHcZBMOfTkj_Lb7aHPryvxC5mxQ@mail.gmail.com>
References: <20190416162305.24375-1-tiny.windzz@gmail.com> <CAPDyKFpR6bwjUG_WtgvXJznBHcZBMOfTkj_Lb7aHPryvxC5mxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, April 17, 2019 10:38:14 AM CEST Ulf Hansson wrote:
> On Tue, 16 Apr 2019 at 18:23, Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > WARN_ON() already contains an unlikely(), so it's not necessary to use
> > unlikely.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/base/power/domain.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 96a6dc9d305c..598a4e02aee1 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -391,11 +391,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >         if (unlikely(!genpd->set_performance_state))
> >                 return -EINVAL;
> >
> > -       if (unlikely(!dev->power.subsys_data ||
> > -                    !dev->power.subsys_data->domain_data)) {
> > -               WARN_ON(1);
> > +       if (WARN_ON(!dev->power.subsys_data ||
> > +                    !dev->power.subsys_data->domain_data))
> >                 return -EINVAL;
> > -       }
> >
> >         genpd_lock(genpd);
> >
> > --
> > 2.17.0
> >
> 

Patch applied, thanks!



