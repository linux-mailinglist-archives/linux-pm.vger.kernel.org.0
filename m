Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C507D2336B2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgG3Q0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 12:26:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38042 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Q0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 12:26:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id u63so12465730oie.5;
        Thu, 30 Jul 2020 09:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4y0trLDvxFm6X9a9D00px5raiFD5iq1zLoW+q4WbwgE=;
        b=S8DvwnfIkhcuck+8UPqNgoZDWdfAqKvhbSViRr7h0sycvWUl6elj9cMKfFsrAue19Z
         ieczi74JoDRE4Mh3J5Q0nuqmQL9wimmiFBGZ/61g70YNxPDeDoHbU60CrAIrNGQ0cZeX
         UTbrQYcNsMEjYuUwa1egfZwtW29KvBtQ7tNh2+NWgwhNiXWbV4bKfJFwfa/6Z6L2cxs5
         O4EXdnFfUe6NndFmUfKLsgtnP94/fx/Ra8qWBZsm3RgrhgrJOuem3PlEbFDWLtv4vIck
         eGe5MhqDV5lg0TTtOaDgQdWntUGV5EMEnO6uCnjwdpliN68+9h8A+WR3vDt2G44McPM1
         HySA==
X-Gm-Message-State: AOAM533v4UhV0gjcvyr6voDClTYTx8iESSzOl9klMKu+Kl/emLGYZ0WR
        bXrIhTjL6EmxYL3/JAHUpaWh0wqbGgMsTOZxoKqbAA==
X-Google-Smtp-Source: ABdhPJxrT6AUgXEocJmQ7pCL9/znNdw1t9+xZb+8yxum3NWoVzCoScjZAmBR1bARnutUs3y1OkCoh27fTFb25d29gug=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr12785075oia.103.1596126370279;
 Thu, 30 Jul 2020 09:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
 <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com>
 <20200730061041.gyprgwfkzfb64t3m@vireshk-mac-ubuntu> <CAHLCerMD_spZFHER-y9dOzr7qo9xKXZdqy3cFt+W9QUW4Ng3jw@mail.gmail.com>
 <20200730064112.lvbwas7zzqruvprk@vireshk-mac-ubuntu>
In-Reply-To: <20200730064112.lvbwas7zzqruvprk@vireshk-mac-ubuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jul 2020 18:25:59 +0200
Message-ID: <CAJZ5v0ia-kjAboeREyDESxp9f_E_SVdDNj0aU4Xgxjf4-=QGTw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cached_resolved_idx can not be negative
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 8:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-07-20, 12:02, Amit Kucheria wrote:
> > Looking at this more closely, I found another call site for
> > cpufreq_frequency_table_target() in cpufreq.c that needs the index to
> > be unsigned int.
> >
> > But then cpufreq_frequency_table_target() returns -EINVAL, so we
>
> It returns -EINVAL only in the case where the relation is not valid,
> which will never happen. Maybe that should be marked with WARN or BUG
> and we should drop return value of -EINVAL.
>
> Rafael ?

Yeah, make it a WARN_ON_ONCE() IMO.

> > should be able to handle int values.
>
> And so no.
>
> > I think you will need to fix the unconditional assignment of
> >     policy->cached_resolved_idx = idx
> > in cpufreq_driver_resolve_freq(). It doesn't check for -EINVAL, so the
> > qcom driver is write in checking for a negative value.
>
> Right, I don't want it to have that check for the reason stated above.
>
> The point is I don't want code that verifies cached-idx at all, it is
> useless.
>
> --
> viresh
