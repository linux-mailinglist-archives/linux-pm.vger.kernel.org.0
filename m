Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60762ADEB2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfIISRo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 14:17:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43086 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfIISRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 14:17:44 -0400
Received: by mail-io1-f65.google.com with SMTP id r8so6037061iol.10;
        Mon, 09 Sep 2019 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYdVLg5vrn2+v8864tTRmAdsj5l5ajHTy87+Fbzgvb8=;
        b=jhJjXXwl/w+QYUN9SFYPij6VJpdMs1ggjjM1oc+f7pw+4dhbaaF+eMI+3cIb0z4BBA
         nzfsnOgx9V9/tLfyrZMFSwRH195NVIg+21DPM+dNsvpRH3qNHg4NDw7eGmFRw6ZKhT7X
         LqnwIumSgmSHQPVsL0UlKRaaim3XL0inAsbCsRDNH+Ysoiexngvuogpi8qRZAcmdQmm5
         puzIIaN4Ke/wmifywIjVNtrKhTmK516IMVnO9or+BBSc5GD0M/3UNmrOC+2YO33Oi9sy
         FfE6wzAl7Ao7Pn9YlaDnP/Ayy/vt1zyfDWxaCz8MvfVMDsz5rdpGtIMp2VXvIX8929Oi
         0uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYdVLg5vrn2+v8864tTRmAdsj5l5ajHTy87+Fbzgvb8=;
        b=QeKf9HQAgthMDLEAq9hF6sjYQ9lPXfDiG7CaPKHy6OkxBZDh1fSjc1TtM7HTWNaO+9
         NG9NnRb1ReWF7Ex2HMRFlCm56TOdpG9pkkpzXFL7xOJExlUGzev6JLpNWRcuq04+ZcPY
         4bAgQwPGGptJ5YMdjl3+PLP/VtruxmD58msMDC1RHqTirq89CxpDGZxi/wXf0a8od1Cg
         SJswQaeAVlp3o4d0Fo1+UvSPFKHf4dNfxQhHNprIRzUWFQ+wiCVs/ccaNgIA+9/D3Xuf
         Cu5+mgHRlu9EOtTlPMnvBfhMQm1epHBMctHeD18k0hhAYqp/KXCocDNbCxN7UBxcw7Fa
         mG1g==
X-Gm-Message-State: APjAAAX9rfecBk4eRppbGjqeX6ErsqL0rlACmaD85U5tSqJ+749f+H2R
        vownt/tL7KEC/cohzvASJiVbINOdg3hpPPWbsGY=
X-Google-Smtp-Source: APXvYqw2072qQKyfGHpuM3xMhnjkcVGtaFOrWjQed33uDkY63s1ahOODakIHw3cC8NZ5Dw71qJaPSoHkiNwyOP1sCpY=
X-Received: by 2002:a02:b395:: with SMTP id p21mr28318388jan.52.1568053061441;
 Mon, 09 Sep 2019 11:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190909154502.19804-1-aford173@gmail.com> <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com>
In-Reply-To: <6081134F-AACD-412C-B36A-BF9463C9712B@goldelico.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 9 Sep 2019 13:17:29 -0500
Message-ID: <CAHCN7xLfOo7xsmDq5ZuPZsh02pjKx3w9FkJGN6AowJoHkRrWmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: ti-cpufreq: Add support for AM3517
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        =?UTF-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>,
        Adam Ford <adam.ford@logicpd.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 9, 2019 at 1:13 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Adam,
>
> > Am 09.09.2019 um 17:45 schrieb Adam Ford <aford173@gmail.com>:
> >
> > The AM3517 only lists 600MHz @ 1.2V, but the revister values for
>
> a small typo...
>
> s/revister/register/
>
> > 0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
> > of the omap36 which has OPPs would be OPP50 (300 MHz) and OPP100
> > (600 MHz).
> >
> > This patch simply enable adds the am3517 to the compatible table
> > using the omap3630 structure instead of the 3430.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index f2f58d689320..6b69fb1d6bdf 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -270,6 +270,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
> >
> > static const struct of_device_id ti_cpufreq_of_match[] = {
> >       { .compatible = "ti,am33xx", .data = &am3x_soc_data, },
> > +     { .compatible = "ti,am3517", .data = &omap36xx_soc_data, },
> >       { .compatible = "ti,am43", .data = &am4x_soc_data, },
> >       { .compatible = "ti,dra7", .data = &dra7_soc_data },
> >       { .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
> > --
> > 2.17.1
> >
>
> Looks good to me.
>
> Should I include your two patches to my patch set (and resend)?
> Or should we keep them separated?

Go ahead and take credit for them.  I just did what you told me to do
and tested them.
Go ahead and mark it as Tested-by with my name.

adam
>
> BR and thanks,
> Nikolaus
>
