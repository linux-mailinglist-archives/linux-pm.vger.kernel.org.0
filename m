Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189BC422B17
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhJEOgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 10:36:24 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:36395 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhJEOgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 10:36:24 -0400
Received: by mail-oo1-f53.google.com with SMTP id e19-20020a4a7353000000b002b5a2c0d2b8so6476514oof.3
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 07:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75DuAniA5Nj8XcPFApJLWKorrKOQHgCdN2R+n/W0yes=;
        b=kdzasEuVCGiBC58JcIW+FhCiedkYGOGL1/Cm8CjfOq3dbhriXdYHlvYYim/pubB4Lg
         x4VMB0YUJSsevgPdPtx4vPBODz/RJrem0t8nwnVMuvJ0Hi2MM1bDK0KDcMI5kPiukYHw
         OzsQ6cCMxbZ78V4WWO3kZzlqCCotxEQLlGLcFlfsGABY73/76klcUee1sBVu2PxyKTDp
         RMrkAjL8sX5s5yE0/63vlj7xWMCOHQkXIN3E7BcxufFxDRUUxfXGYDE3LgzBXS9cjsUb
         4ZRE1vZudnK9A8b1hULdhKvnowoEHJtdJPiw4H7yW6IfcbyyDODOueqfPY/RpKGr2B4q
         ETRg==
X-Gm-Message-State: AOAM530Y95Oz2KqnbFmW7nRsyp5P/GZu0ehnKqVBrJTCh28BG8rcCV24
        peLcPIH/7kIcuzQ/3Xg3u3eLE10k13+XhM0Pivo=
X-Google-Smtp-Source: ABdhPJxKSUl1ANkzjo6LiJkxZbewuxg2UHlqSPxInwe8supD2sfdqrNDKv91MpgTk2V4tlrhjDfgUFDC6KjAnNHTzEg=
X-Received: by 2002:a4a:7655:: with SMTP id w21mr169248ooe.30.1633444473193;
 Tue, 05 Oct 2021 07:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com> <20211004092508.tokhwodfa73terif@vireshk-i7>
In-Reply-To: <20211004092508.tokhwodfa73terif@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 16:34:22 +0200
Message-ID: <CAJZ5v0g1S2+rXH7pZpZhG3ShZc1r5jpS=ham7BM3j6c0OncLaw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Inefficient OPPs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 4, 2021 at 11:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-09-21, 15:05, Vincent Donnefort wrote:
> > Hi all,
> >
> > Here's the new version for the inefficient OPPs. This patch-set is based on the
> > following series from Viresh:
> >
> >   [PATCH V3 0/9] Add callback to register with energy model
> >   https://lore.kernel.org/linux-arm-msm/cover.1628742634.git.viresh.kumar@linaro.org/
> >
> > The main change in this version is the re-introduction of CPUFREQ_RELATION_E,
> > as a relation flag. When set, all relations will try to resolve a frequency
> > across efficient frequencies only.
> >
> > A bit of context:
> >
> > We (Power team in Arm) are working with an experimental kernel for the
> > Google's Pixel4 to evaluate and improve the current mainline performance
> > and energy consumption on a real life device with Android.
> >
> > The SD855 SoC found in this phone has several OPPs that are inefficient.
> > I.e. despite a lower frequency, they have a greater cost. (That cost being
> > fmax * OPP power / OPP freq). This issue is twofold. First of course,
> > running a specific workload at an inefficient OPP is counterproductive
> > since it wastes wasting energy. But also, inefficient OPPs make a
> > performance domain less appealing for task placement than it really is.
> >
> > We evaluated the change presented here by running 30 iterations of Android
> > PCMark "Work 2.0 Performance". While we did not see any statistically
> > significant performance impact, this change allowed to drastically improve
> > the idle time residency.
> >
> >
> >                            |   Running   |  WFI [1]  |    Idle   |
> >    ------------------------+-------------+-----------+-----------+
> >    Little cluster (4 CPUs) |    -0.35%   |   +0.35%  |   +0.79%  |
> >    ------------------------+-------------+-----------+-----------+
> >    Medium cluster (3 CPUs) |    -6.3%    |    -18%   |    +12%   |
> >    ------------------------+-------------+-----------+-----------+
> >    Big cluster    (1 CPU)  |    -6.4%    |    -6.5%  |    +2.8%  |
> >    ------------------------+-------------+-----------+-----------+
> >
> > On the SD855, the inefficient OPPs are found on the little cluster. By
> > removing them from the Energy Model, we make the most efficient CPUs more
> > appealing for task placement, helping to reduce the running time for the
> > medium and big CPUs. Increasing idle time is crucial for this platform due
> > to the substantial energy cost differences among the clusters. Also,
> > despite not appearing in the statistics (the idle driver used here doesn't
> > report it), we can speculate that we also improve the cluster idle time.
> >
> > [1] WFI: Wait for interrupt.
> >
> > Changelog since v6:
> >   - Bring back CPUFREQ_RELATION_E as a relation flag.
> >   - Make the policy min/max hard limits.
> >   - Remove the "efficient" member from the freq_table that was pointing to the
> >     next efficient frequency.
>
> Had a quick look, LGTM.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

All patches in the series applied as 5.16 material, thanks!
