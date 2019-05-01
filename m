Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328FD1070F
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfEAKlL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:41:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62017 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfEAKlL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:41:11 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 7927eb6e3a1ebc0d; Wed, 1 May 2019 12:41:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Tang <andy.tang@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
Date:   Wed, 01 May 2019 12:41:08 +0200
Message-ID: <2243345.ebHGfCmnM5@kreacher>
In-Reply-To: <CAJZ5v0jOOKW92X8iGPZD8Dfye4K9seXgiYaTLURby9Y3BbMYpg@mail.gmail.com>
References: <20190424023223.29614-1-andy.tang@nxp.com> <20190424090252.7cmwzxf4t5lwjat6@vireshk-i7> <CAJZ5v0jOOKW92X8iGPZD8Dfye4K9seXgiYaTLURby9Y3BbMYpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, April 24, 2019 11:25:07 AM CEST Rafael J. Wysocki wrote:
> On Wed, Apr 24, 2019 at 11:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 24-04-19, 09:24, Rafael J. Wysocki wrote:
> > > On Wed, Apr 24, 2019 at 6:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> > > > > From: Yuantian Tang <andy.tang@nxp.com>
> > > > >
> > > > > Enable cpufreq feature on ls1028a chip by adding its compatible
> > > > > string.
> > > > >
> > > > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > > > ---
> > > > >  drivers/cpufreq/qoriq-cpufreq.c |    1 +
> > > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > > > > index 4295e54..d308c4d 100644
> > > > > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > > > > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > > > > @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
> > > > >
> > > > >       { .compatible = "fsl,ls1012a-clockgen", },
> > > > >       { .compatible = "fsl,ls1021a-clockgen", },
> > > > > +     { .compatible = "fsl,ls1028a-clockgen", },
> > > > >       { .compatible = "fsl,ls1043a-clockgen", },
> > > > >       { .compatible = "fsl,ls1046a-clockgen", },
> > > > >       { .compatible = "fsl,ls1088a-clockgen", },
> > > >
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > So do you want me to take this one directly?
> >
> > I actually applied it and then realized it is powerpc and so dropped
> > it. You want me to apply it ?
> 
> No, I can do that, thanks!
> 

Applied, thanks!




