Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A510CCB1D
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2019 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJEQ3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Oct 2019 12:29:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38256 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJEQ3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Oct 2019 12:29:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so13152308qta.5;
        Sat, 05 Oct 2019 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stUeq6JlpWLFXyg96f1LSeLONzeqiyJLX5utdPTxFBc=;
        b=Zep7EH8pO7JmpCe1G6r56TuRXPs8YmKTwcXPCZweibMkKiGXZMWHc6qpaIp+5wDNz+
         EbNm5u6fD0FDeKKxhzIA+j3tNR6X1WNjAre6pmf4PNQvaL41sbiwmkfNucY1ACzskB01
         mqkKEaeK+uCu9ZjDznOPUUvjtHROgircblQeiLTXb/9owXTCcBnKbdC3WXWPOdnAqMbS
         XWgKfr4hdLUnL/4QF4mmE86Wofm+QPRCocTJeho/6Jr1T6jbWezdeBrwLmKtBC4xoiU2
         I7unuYdrSt/Q1On4Az055jSgBRGwh/VGeJ4Bmgxd3P1cJtiVc7kvlI9gezaYlt8L6iW5
         0RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stUeq6JlpWLFXyg96f1LSeLONzeqiyJLX5utdPTxFBc=;
        b=Ji0k0bvdPPp01oUdvg/d+Pq5xefjfnlNH2n2JC3ANrHnIpI77IPKiM8rXbXIG30O/H
         t4pAKk7yVqX0Zd9F591O+4xL2Sda/9YVgRZLfG3QzV2YOeZiFv1pwFPDjAY0WSN7PTDJ
         IbNA+gbmP8qVzJeg3725ekeMXI5EOrbvA7QUmN/OUqkHVspkQNs5H8UfP+SqZ53mT5SE
         cBCtC8yvIMxI16TkPOUTbVIOY7r7G1nzk13+IENICDaFbibTGQ711Yb+xb+5clY2tdpB
         NxXa2tUx1dhNpskDpfJ4U5hDWuIfCcCfdKf9aaOsWnkWqEG11hOOE8rY168O4+st1vcZ
         z6EA==
X-Gm-Message-State: APjAAAUbJv9gpbOq/rywl4VeAX03hOQLTxe+x1AGTE1oMi2YwyO8hwFf
        ZHmY9vakx9PY98FtaEo+2FM3xVVDPhieUBcoRIs=
X-Google-Smtp-Source: APXvYqxNyxoLcySUggUDZfaxP5Da7HAD7Adv9zfmVwgCcVpJM5x3JqZze9SC4wgB358kMmJv8LN2WzAvOoHYVEEY5wc=
X-Received: by 2002:ac8:3021:: with SMTP id f30mr21994609qte.193.1570292991651;
 Sat, 05 Oct 2019 09:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190811212315.12689-1-digetx@gmail.com> <CGME20191001211534epcas2p1e5f878969d3f68d4dfcafd82b1538487@epcas2p1.samsung.com>
 <17dabcfc-3351-13a1-b3de-81af88f64d84@gmail.com> <503b2ade-ff8e-c354-3886-3b7b511bd07e@samsung.com>
 <6967777e-b54f-8021-aa6d-8c245e529e10@gmail.com>
In-Reply-To: <6967777e-b54f-8021-aa6d-8c245e529e10@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 5 Oct 2019 12:29:40 -0400
Message-ID: <CAMdYzYrgvRK49ZhXfy4T6EsRmWOmB+uNK9+rumL1mX032=CdWA@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] More improvements for Tegra30 devfreq driver
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested on the Ouya (tegra30).

Tested-by: Peter Geis <pgwipeout@gmail.com>

On Wed, Oct 2, 2019 at 9:56 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 02.10.2019 03:25, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hello Dmitry and Thierry,
> >
> > On 19. 10. 2. =EC=98=A4=EC=A0=84 6:15, Dmitry Osipenko wrote:
> >> 12.08.2019 00:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Hello,
> >>>
> >>> This series addresses some additional review comments that were made =
by
> >>> Thierry Reding to [1], makes several important changes to the driver,
> >>> fixing excessive interrupts activity, and adds new features. In the e=
nd
> >>> I'm proposing myself as a maintainer for the Tegra devfreq drivers.
> >>>
> >>> [1] https://lore.kernel.org/lkml/0fb50eb1-a173-1756-6889-2526a10ac707=
@gmail.com/T/
> >>>
> >>> Changelog:
> >>>
> >>> v6:  Addressed review comment that was made by Chanwoo Choi to v5 by
> >>>      squashing "Define ACTMON_DEV_CTRL_STOP" patch into the "Use CPUF=
req
> >>>      notifier" patch.
> >>>
> >>> v5:  Addressed review comments that were made by Chanwoo Choi to v4 b=
y
> >>>      squashing few patches, dropping some questionable patches, rewor=
ding
> >>>      comments to the code, restructuring the code and etc.
> >>>
> >>>      These patches are now dropped from the series:
> >>>
> >>>        PM / devfreq: tegra30: Use tracepoints for debugging
> >>>        PM / devfreq: tegra30: Inline all one-line functions
> >>>
> >>>      The interrupt-optimization patches are squashed into a single pa=
tch:
> >>>
> >>>        PM / devfreq: tegra30: Reduce unnecessary interrupts activity
> >>>
> >>>      because it's better to keep the optimizations as a separate chan=
ge and
> >>>      this also helps to reduce code churning, since the code changes =
depend
> >>>      on a previous patch in order to stay cleaner.
> >>>
> >>>      Fixed a lockup bug that I spotted recently, which is caused by a
> >>>      clk-notifier->cpufreq_get()->clk_set_rate() sequence. Now a non-=
blocking
> >>>      variant of CPU's frequency retrieving is used, i.e. cpufreq_quic=
k_get().
> >>>
> >>>      Further optimized the CPUFreq notifier by postponing the delayed
> >>>      updating in accordance to the polling interval, this actually un=
covered
> >>>      the above lockup bug.
> >>>
> >>>      Implemented new minor driver feature in the new patch:
> >>>
> >>>        PM / devfreq: tegra30: Support variable polling interval
> >>>
> >>> v4:  Added two new patches to the series:
> >>>
> >>>        PM / devfreq: tegra30: Synchronize average count on target's u=
pdate
> >>>        PM / devfreq: tegra30: Increase sampling period to 16ms
> >>>
> >>>      The first patch addresses problem where governor could get stuck=
 due
> >>>      to outdated "average count" value which is snapshoted by ISR and=
 there
> >>>      are cases where manual update of the value is required.
> >>>
> >>>      The second patch is just a minor optimization.
> >>>
> >>> v3:  Added support for tracepoints, replacing the debug messages.
> >>>      Fixed few more bugs with the help of tracepoints.
> >>>
> >>>      New patches in this version:
> >>>
> >>>        PM / devfreq: tegra30: Use tracepoints for debugging
> >>>        PM / devfreq: tegra30: Optimize CPUFreq notifier
> >>>        PM / devfreq: tegra30: Optimize upper consecutive watermark se=
lection
> >>>        PM / devfreq: tegra30: Optimize upper average watermark select=
ion
> >>>        PM / devfreq: tegra30: Include appropriate header
> >>>
> >>>      Some of older patches of this series also got some extra minor p=
olish.
> >>>
> >>> v2:  Added more patches that are cleaning driver's code further and
> >>>      squashing another kHz conversion bug.
> >>>
> >>>      The patch "Rework frequency management logic" of the v1 series i=
s now
> >>>      converted to "Set up watermarks properly" because I found some p=
roblems
> >>>      in the original patch and then realized that there is no need to=
 change
> >>>      the logic much. So the logic mostly preserved and only got impro=
vements.
> >>>
> >>>      The series is based on the today's linux-next (25 Jun) and takes=
 into
> >>>      account minor changes that MyungJoo Ham made to the already queu=
ed
> >>>      patches from the first batch [1].
> >>>
> >>> Dmitry Osipenko (19):
> >>>   PM / devfreq: tegra30: Change irq type to unsigned int
> >>>   PM / devfreq: tegra30: Keep interrupt disabled while governor is
> >>>     stopped
> >>>   PM / devfreq: tegra30: Handle possible round-rate error
> >>>   PM / devfreq: tegra30: Drop write-barrier
> >>>   PM / devfreq: tegra30: Set up watermarks properly
> >>>   PM / devfreq: tegra30: Tune up boosting thresholds
> >>>   PM / devfreq: tegra30: Fix integer overflow on CPU's freq max out
> >>>   PM / devfreq: tegra30: Ensure that target freq won't overflow
> >>>   PM / devfreq: tegra30: Use kHz units uniformly in the code
> >>>   PM / devfreq: tegra30: Reduce unnecessary interrupts activity
> >>>   PM / devfreq: tegra30: Use CPUFreq notifier
> >>>   PM / devfreq: tegra30: Move clk-notifier's registration to governor=
's
> >>>     start
> >>>   PM / devfreq: tegra30: Reset boosting on startup
> >>>   PM / devfreq: tegra30: Don't enable consecutive-down interrupt on
> >>>     startup
> >>>   PM / devfreq: tegra30: Constify structs
> >>>   PM / devfreq: tegra30: Include appropriate header
> >>>   PM / devfreq: tegra30: Increase sampling period to 16ms
> >>>   PM / devfreq: tegra30: Support variable polling interval
> >>>   PM / devfreq: tegra20/30: Add Dmitry as a maintainer
> >>>
> >>>  MAINTAINERS                       |   9 +
> >>>  drivers/devfreq/tegra30-devfreq.c | 706 +++++++++++++++++++++++-----=
--
> >>>  2 files changed, 555 insertions(+), 160 deletions(-)
> >>>
> >>
> >> Hello Chanwoo,
> >>
> >> I don't have any more updates in regards to this series, everything is
> >> working flawlessly for now. Will be awesome if we could continue the
> >> reviewing and then get the patches into linux-next to get some more te=
sting.
> >>
> >>
> >
> > Hello Dmitry,
> >
> > I'm sorry for late reply. Except for patch5, I reviewed the patches.
> > Please check my comment. Actually, It is difficult to review the patch5
> > without any testing environment and detailed knowledge of watermark of =
tegra.
> > It is not familiar with me.
>
> Thank you very much! I'll go through yours comments and reply to them.
>
> I understand that it's not easy for you to review patch5, but probably
> you don't need to go into details and a brief-generic review of the code
> will be enough in that case.
>
> The hardware is actually very simple, there are watermarks that
> correspond to a memory activity that hardware accounts over a given
> period of time. Once watermark is reached, hardware generates interrupt.
> There are two types of watermarks: average and consecutive. In case of
> the average, the memory activity is collected over a larger window of
> time. For the consecutive case, the memory activity is collected over
> each period (16ms by default in the driver). Memory client may breach
> average watermark very frequently, although that may not affect much the
> average value and for some memory clients (like CPU) it is more
> preferred to not completely ignore those short bursts of memory
> activity. The consecutive watermarks are used in order to detect those
> short bursts, which we account in the driver in a form of boosting. You
> may notice that boost_up_coeff for the CPU's memory client is set to a
> higher value in the driver.
>
> > Hello Thierry,
> > If possible, Could you review the patch5 related to setting up the wate=
rmark
> > and other patches?
> >
>
> Indeed, will be very nice if Thierry could also take a look at this
> series. Although.. I could be wrong here, but it looks to me that
> Thierry also isn't closely familiar with this driver and the hardware.
>
> Thierry, at least please let us know if you're interested in taking a
> look at the patches, I'm pretty sure that you're quite busy with other
> things ;)
