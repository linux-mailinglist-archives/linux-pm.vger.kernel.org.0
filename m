Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF22740599F
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbhIIOsa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbhIIOsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:48:19 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54359C066408
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:40:32 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id p2so2779055oif.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jtd5ppqH31n/KLK+cY13LK3FdPrs9pVeJq1VDs1R2lE=;
        b=KKGZ29/Xf4HSszxMgUaFJTKQv3zzYHHXdnMRgFnoxoqoPD7+ujOeh8GPIkaQkGbDEv
         7HbNKuK5n6DSdLkMCI5RlHARjoXk/UiZ0U03o12o5SKhmPAFoZSq17w3IeqdKHb10is+
         kaBZIzzawugaqnYDsC78lTzTyXHSIBJ/QL2iPQQy2EnNmHEGr2kVwSOebIjBK9fx4UzQ
         RGI82kI7ttS7zyzifIDV2llA0W6lNAE6dST0N9ucTKochfU/6mluLqffFMuyNU6mvy7i
         ksnRAefIAVGqonBiCzBhPxEcbEfLTHDFiv1abbKMFayxCBycaDXp8BwhokWiqJFYYlp3
         rxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jtd5ppqH31n/KLK+cY13LK3FdPrs9pVeJq1VDs1R2lE=;
        b=1/URg7Ak+ctgrPcGeg7X2BlPF/YRCCTR/5z6sQeqjhhsxI0Xkm/dUUHJFgVgPlj96p
         MHjwH1duTS3l40/Xvp8mlyK/Nzzk1tmJD98tn937KhYsBA8f33gLtTFrfIJaDB2/ghQi
         N2fYAZkw0o8Asib5uT9SJWO3sB1cOY+0J7bdPKlgt+raK2Ob3ANA+KtiTzc1HnUieJfh
         3QF5qRRjT3Vs07if5GRcYxu8QvOuGQs3k6YKwf3/g9yAzYN5zJA+r/JHDQfJEAVz8OGe
         5Mx/WbR7bmVgrLklgB+8wD8UxgVBRsrOyR6aLL3n3BA+agNc/p6ffzCaAom90vcKelQF
         +5Rg==
X-Gm-Message-State: AOAM5330wILgewoMUKHT/OIc63fywDfgmtvk0xnyrjr2n3lNtO/AIUNF
        OUcHkWX9nckbLapKOh8Dy1qOw8H/MKwF0vupE4jaVg==
X-Google-Smtp-Source: ABdhPJw/RybYhxhDG88FRwwrkzIYw9ZgM89JO9ORsmkh9M8pAyrNBjPnRbDyIPYQi1wnphI8HcR4jaSgn3BOjRFp/I0=
X-Received: by 2002:a54:4f03:: with SMTP id e3mr93670oiy.32.1631198431526;
 Thu, 09 Sep 2021 07:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210902101634.827187-1-ulf.hansson@linaro.org>
 <20210902101634.827187-4-ulf.hansson@linaro.org> <4e36e732-6ca3-1d00-e6dd-38bb8877577b@gmail.com>
 <CAPDyKFr2oQnKOhKhWt_9VyBoe=HQ7Y0uZUMKTcZ05a7G9RaBYA@mail.gmail.com>
 <1124dae5-478f-f0ca-ea91-b6945f7c9254@gmail.com> <CAPDyKFqE+thX0pLTg9d-ds7Tj3hsB78EmDB1Cryh26tN3kvQDA@mail.gmail.com>
 <3d92711f-ce30-2c19-c6a4-bb77d32df2dd@gmail.com> <CAPDyKFpJU3g2OzJeR9KUdtN-8wJsDckqVAMQMHBV=enu=DfURg@mail.gmail.com>
 <fbca049a-e673-1598-658f-a7bb5de52f18@gmail.com> <CAPDyKFqw2tp3-J8dW03Kqw9xC_gO7nWfEckMvT3=zB0AbR8jeA@mail.gmail.com>
 <1ca9a2d5-e89a-5bbd-2ecc-01f1c4a820ae@gmail.com>
In-Reply-To: <1ca9a2d5-e89a-5bbd-2ecc-01f1c4a820ae@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Sep 2021 16:39:54 +0200
Message-ID: <CAPDyKFoFCVcjrGXQ56y0iSNPhE8-orpZiHvnAQTQW1b8oW4f5A@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: domains: Add a ->dev_get_performance_state()
 callback to genpd
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 9 Sept 2021 at 15:48, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 07.09.2021 12:57, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I don't mind extending the genpd API, but it needs to serve a good purp=
ose.
> >
> > As I said earlier, genpd doesn't know nor can control how the consumer
> > driver deploys runtime PM. Unfortunately, that also includes genpd
> > providers, as the behavior isn't a platform or PM domain specific
> > thing. This means genpd needs to be generic enough so it works for all
> > cases.
> >
> > In the $subject patch, we rely on the pm_runtime_suspended() check in
> > dev_pm_genpd_set_performance_state(), which should work for all cases,
> > even if it may be sub-optimal for some scenarios.
> >
> > Note that, in the approach your suggested [1],
> > pm_runtime_status_suspended() is used instead. This doesn't work when
> > a consumer driver doesn't enable runtime PM - or calls
> > pm_runtime_set_active() during ->probe(), because
> > genpd_runtime_resume() won't be invoked to restore the gpd->rpm_state.
> >
> > That said, I wouldn't mind to simply skip adding the
> > ->dev_get_performance_state() all together, if that is what you
> > prefer? In this way, it becomes the responsibility for the consumer
> > driver to do right thing, with the cost of some boilerplate code added
> > in its ->probe() routine.
>
> Until a day ago, it wasn't clear to me that consumer drivers now can set
> up rpm_pstate during probe(), which is a cleaner solution that works
> well. So let's skip adding the questionable ->dev_get_performance_state()=
.
>
> The boilerplate code in the probe() is minimal in comparison to a
> previous variant with the state-syncing done by rpm-resume callbacks of
> consumer drivers, it's good enough.

Alright, that sounds good to me as well.

I am happy to help with review of the consumer driver changes, just
keep me posted.

Thanks and kind regards
Uffe
