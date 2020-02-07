Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E777C155B2B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 16:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGPxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 10:53:30 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45731 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGPx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 10:53:29 -0500
Received: by mail-vk1-f195.google.com with SMTP id g7so708672vkl.12
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2020 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95ygi45qtZTOWH+UKxvi28hwPyGfXfy4ZjYmQW0i/SI=;
        b=j75d0oaRHNtEC+MzXfW9/nEOcgNA3FX81yhp5QL/gzqPhUE9bPTWd7pIxDD2tJdnoD
         lFmTVekPy83AuHK4oQrEsq7ftUURUTxJ9cHEJpWShoUGKC0ikjyESDkEfo8X9qs8uQ0m
         1osZusZiWV377s0jr3USuUDihezOV+4A9lYiyNvEx56g8jrfZqDXuQScNUWvqEMIT7fG
         AWvRwjQUiCGGUaGqNp3SB61dlAhcik3Tclg3r5SvBOBcgCOvcp5gOxIg56wQNV83RPMG
         Jpw/4RXYPSqBvoXTgAIiHft1h8B9m9pNJxvFxh4+uP1R3i6r3x+T6WF6k6axZtfvLetf
         apYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95ygi45qtZTOWH+UKxvi28hwPyGfXfy4ZjYmQW0i/SI=;
        b=sLvhA5DedEfiW8yOYZyZdKNO1AlHadcKgCJjhR2Ac5NvHpi7cuQc7nKCFUIgRxUyzB
         QZbMI5RdfTs6ybofnCAUyDvsD19tF5wh0vRQIZb8/4M+77Iji/+FEyGPAzttQKlFES0S
         9LPCEBbTcDQiP8LjXxcDf11Iz550ScXDR8XMOxFG47RByPsFasuqQpIubOWBlvqCb+k9
         0lGjFgRw3BYHGwC0mCj7PqTg81pVHuXg147weJjWwpm1A8XWpqVf2fqPONloUeJDnh1d
         zHqNjbCHSO8rwEEYb7LndlpQak53wj5NhDrwY4hA8o035P+ar0XfgtRZzhB0Et+Wdv3M
         umPQ==
X-Gm-Message-State: APjAAAWzmv2LhR8Bu/Kw62swYkIXriD4PmI1sCpb7nNfPb/N1BeFfbQd
        Ry/iC4dRBDB+Y74buwE/ffvBLZ0xhSVz5wUqTzWIMQ==
X-Google-Smtp-Source: APXvYqwFFtbUIctx3YdFoC4QriFsEms4xU7w6LquZ748k027glxZE0QklHy04PJmF/kHORQ6R34TsyT2ppLdjjIsU0w=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr5084872vka.53.1581090808740;
 Fri, 07 Feb 2020 07:53:28 -0800 (PST)
MIME-Version: 1.0
References: <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus> <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus> <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
 <20200205161816.GD38466@bogus> <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
 <20200206204514.GB8107@codeaurora.org> <20200207111955.GA40103@bogus>
 <CAPDyKFp-zvD1iFcpRaTFiuazxYmLEx0Czf3=TZJxjSCDmmPsvA@mail.gmail.com> <20200207144850.GA18655@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200207144850.GA18655@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Feb 2020 16:52:52 +0100
Message-ID: <CAPDyKFoZ+QQFdG3yQ5wGpg2Z5c9WksUhresGz02o3HVrGt1UhQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 7 Feb 2020 at 15:48, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Feb 07, 2020 at 01:32:28PM +0100, Ulf Hansson wrote:
> > [...]
> >
> > > > I understand the arguments for using PC vs OSI and agree with it. But
> > > > what in PSCI is against Linux knowing when the last core is powering
> > > > down when the PSCI is configured to do only Platform Cordinated.
> > >
> > > Nothing :D. But knowing the evolution and reasons for adding OSI in the
> > > PSCI specification and having argued about benefits of OSI over PC for
> > > years and finally when we have it in mainline, this argument of using
> > > PC for exact reasons why OSI evolved is something I can't understand
> > > and I am confused.
> > >
> > > > There should not be any objection to drivers knowing when all the cores
> > > > are powered down, be it reference counting CPU PM notifications or using
> > > > a cleaner approach like this where GendPD framwork does everything
> > > > cleanly and gives a nice callback. ARM architecture allows for different
> > > > aspects of CPU access be handled at different levels. I see this as an
> > > > extension of that approach.
> > > >
> > >
> > > One thing that was repeatedly pointed out during OSI patch review was no
> > > extra overhead for PC mode where firmware can make decisions. So, just
> > > use OSI now and let us be done with this discussion of OSI vs PC. If PC
> > > is what you think you need for future, we can revert all OSI changes and
> > > start discussing again :-)
> >
> > Just to make it clear, I fully agree with you in regards to overhead
> > for PC-mode. This is especially critical for ARM SoCs with lots of
> > cores, I assume.
> >
> > However, the overhead you refer to, is *only* going to be present in
> > case when the DTS has the hierarchical CPU topology description with
> > "power-domains". Because, that is *optional* to use, I am expecting
> > only those SoC/platforms that needs to manage last-man activities to
> > use this layout, the others will remain unaffected.
>
> In PC mode not only there is no need but it is wrong to manage
> any last-man activity in the kernel. I wonder why we are still
> talking about this to be honest.

I guess the discussion is here because there is a use case to consider now.

For sure, we agree on what is the best solution. But this is rather
about what can we do to improve the current situation, if we should do
anything.

>
> Code to handle PSCI platform coordinated mode has been/is in
> the kernel today and that's all is needed according to the PSCI
> specifications.

PSCI specifies CPU power management, not SoC power management. If
these things were completely decoupled, I would agree with you, but
that's not the case. Maybe SCMI, etc, helps with this in future.

Anyway, my fear is that not many ARM vendors implements OSI support,
but still they have "last-man-activities" to deal with. This is not
only QCOM.

I guess an option would be to add OSI support to the public ARM
Trusted Firmware, then we could more easily point to that - rather
than trying to mitigate the problem on the kernel side.

Kind regards
Uffe
