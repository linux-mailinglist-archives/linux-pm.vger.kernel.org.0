Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF6E2FCEC9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbhATLGG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 06:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbhATJre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 04:47:34 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35216C061575
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 01:46:51 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id s2so12725346vsk.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhkW5Un12MQxFKkR9JsfkRF/gz1LnCi9m0FMvMURDwI=;
        b=EDHUMoJhmI1vDbf8WoGqzB0P8ceHOj5SdAnr2Fra+YO2uuty8NaFRqlpwt1+fuHAbu
         btkX0AfouIJVoNP4D95p9U/fmMZco3eBu7FcIEdWDZqvfghi7T8Z1V2P9l+VF9KpOfDJ
         WJOSPi+ZFWYoaZ1CUtwlfV5exs58PEPnZDh1t+DRVhTOQ8jd1OIrOUBctpJtNrWX2uOY
         E6lwdvlFe7m1GwvtJESG69Q+SsqsbG0Jy/2IjdQx+k9rqUrVB4ilgjP/sAT7SQupFwPV
         IMRUpCQ5EwwbE14Z9WPtQWh8Eeo180qitc4WtpQYUVRuhPWdz70SGwIox3WTVWzZencA
         CzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhkW5Un12MQxFKkR9JsfkRF/gz1LnCi9m0FMvMURDwI=;
        b=he3TGC0E9jNpyMmyDB8PMKOLAG9QIRlTv2Rw8Lo4FhGpnw2EKnFpHZHOB6mUZDXhQJ
         pKil4ymp/C82mHoYq3hTnAxXjas9hCIea6ts32jG+vufmoeRc09wRKcVaZ2xVnv0kdsR
         89c7nShPddq4vsm+z6KrMZckFljU7OJnrz4eMBaj3A001lBOpJJPabOJGIuxqwlHmjub
         Ye4CXkOZJ0TtP5NIY5FoOH326CiJ3YtjwGfGVQ346TJsz2+YKiuKh4lC0XR/mLgO3UFy
         +9gjPLfGFDu7ZAjlxj7HUZ4ZvBDWthRnBRWCptoH3nUVViumSXLJ/lxWPgMhQhrDNJju
         caSw==
X-Gm-Message-State: AOAM533DMKfOMMq+XwBq06vQcIrSmk5mMYluN+XlW9EqXESb88OmedPx
        QpyYsDW/DktMbFZw1mCeQ50PAaRx/19i2kZXJKPJJQ==
X-Google-Smtp-Source: ABdhPJwO6uu53BOw77rfLTS5GBUN3JZG76q4E0f/Siu6uksMYN3b96L0snD4x7kn508rPkM54zSM0QQ2t+NOS+nO6Rs=
X-Received: by 2002:a67:f997:: with SMTP id b23mr5655937vsq.34.1611136010227;
 Wed, 20 Jan 2021 01:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20210120015010.14191-1-digetx@gmail.com> <20210120015010.14191-2-digetx@gmail.com>
 <20210120043933.6ilryvgkhvnsrei7@vireshk-i7>
In-Reply-To: <20210120043933.6ilryvgkhvnsrei7@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 10:46:14 +0100
Message-ID: <CAPDyKFp-7CEY42PCEGa97_89Ew6QysbV7pBBQOSLwBKAZwFpvg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PM: domains: Make set_performance_state() callback optional
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 Jan 2021 at 05:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-01-21, 04:50, Dmitry Osipenko wrote:
> > Make set_performance_state() callback optional in order to remove the
> > need from power domain drivers to implement a dummy callback. If callback
> > isn't implemented by a GENPD driver, then the performance state is passed
> > to the parent domain.
> >
> > Tested-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> > [tested on NVIDIA Tegra20/30/124 SoCs]
> > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 9a14eedacb92..0bd0cdc30393 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -297,6 +297,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> >       return state;
> >  }
> >
> > +static int _genpd_xlate_performance_state(struct generic_pm_domain *src_genpd,
> > +                                       struct generic_pm_domain *dst_genpd,
> > +                                       unsigned int pstate)
>
> I would name them as genpd and parent, that makes it more readable for it.

... and while at it, probably also drop the "_" as the prefix of the
function name.

Other than that, please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
