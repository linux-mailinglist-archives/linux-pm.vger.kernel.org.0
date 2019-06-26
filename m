Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9865653D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfFZJHY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 05:07:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44101 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfFZJGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 05:06:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so1742942otl.11;
        Wed, 26 Jun 2019 02:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXcB2j55vLYg6MDB7LwJc9ADk0v2xKnaarUFg29mB3U=;
        b=tmCoC4ZGXaK/d3+Y6luqX0OOFDpCJxWrtnsEw98qgMiGm8YjL3E5Uer/21FDIvegDj
         cFFjxBN+elV02KWn/PcJ5qWwa64CmXnXV8ptrcArpVIFcwDoNFnFy8Au3gnxDZcXsrKC
         zCtRF4VjuarpKUOdxaWvq6+UtFaLccLGGZwNDPCp9SDOpBQYs+e9ixbal7pl12X8/tn7
         ZO2w20B8lrM1xOxoJtvpgC/s8ri90IyfUHtvtaB0kI1HK2jAHnDrtNkCrklMg5jeDJp5
         F5GjlNCISlhsYRxD2q/Q/qDjs/f8mkjDHMhWCtKqynXPYPlU77y8QLUt25lIRCI++VCs
         n/aQ==
X-Gm-Message-State: APjAAAVP4ebMZRvs+9f/1wRPbcvuZef9qUbnJtgsKHsaxwTId+MiPst/
        k0gfJjiE5FFoNmTgTKwt4dzf5CPzNpa0V/W8L1I=
X-Google-Smtp-Source: APXvYqxAMlqMGoLtV/QmBAgMoUUA9cBy7sBIjE9vyQtzL3Kn6zZnoAHCV0Kt+poYGG0SYlg4n+WaG0SHkySo/zYgcng=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr2300310otp.189.1561540009295;
 Wed, 26 Jun 2019 02:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org> <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
 <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org> <20190626063716.cechnzsb75q5lclr@vireshk-i7>
In-Reply-To: <20190626063716.cechnzsb75q5lclr@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jun 2019 11:06:38 +0200
Message-ID: <CAJZ5v0jFXmJ3ikEPQUp-cLv3+ZSnp1kP8CxdkZVofV1BS3+UwQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 26, 2019 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-06-19, 08:02, Daniel Lezcano wrote:
> > On 26/06/2019 04:58, Viresh Kumar wrote:
> > > On 25-06-19, 13:32, Daniel Lezcano wrote:
> > >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > >> index aee024e42618..f07454249fbc 100644
> > >> --- a/drivers/cpufreq/cpufreq.c
> > >> +++ b/drivers/cpufreq/cpufreq.c
> > >> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
> > >>            cpufreq_driver->ready(policy);
> > >>
> > >>    if (cpufreq_thermal_control_enabled(cpufreq_driver))
> > >> -          policy->cdev = of_cpufreq_cooling_register(policy);
> > >> -
> > >> +          of_cpufreq_cooling_register(policy);
> > >> +
> > >
> > > We don't need any error checking here anymore ?
> >
> > There was no error checking initially. This comment and the others below
> > are for an additional patch IMO, not a change in this one.
>
> right, but ...
>
> > >> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> > >> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> > >>  {
> > >>    struct cpufreq_cooling_device *cpufreq_cdev;
> > >>    bool last;
> > >>
> > >> -  if (!cdev)
> > >> -          return;
>
> we used to return without any errors from here. Now we will have
> problems if regsitering fails for some reason.

Specifically, the last cpufreq_cdev in the list will be unregistered
AFAICS, and without removing it from the list for that matter, which
isn't what the caller wants.
