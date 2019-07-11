Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC20766217
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGKXRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 19:17:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44107 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGKXRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 19:17:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so7586702otl.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 16:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF/FATHnyDx4kXpuDdrKjFESLigVlsCwyIyMGRSOv5o=;
        b=dXUXhqnVpjdzJkRR84wx1ie47Lkb5xFZc0F1De5WarK7idFmMRbSp659Q9zkEIKemE
         nnZGFifafl6P2MI62eBFkmcptAKt44aAzoX40E/Yxu2T+SMvkRxDA4SeLCzZKkFfcXOb
         +Gg1v6vrTLy9fsxv46ddYIITt6G6QGwaFEsNkeYFtFWZPXOWE6IUXRMLWfhmkq+uP5dr
         ugR+4/L3EpBxrCmypbwDnlmK4ZDHw1RF6HnzvI9DAg0Agq9PNboqsgpOiDPSZPfQOrhA
         Zhjn4BFpbehfFcELpg9w5RnewGRZPmBzTW5rKf3KS5gb6ktdKebrfNS/rNm9iz+8+ky4
         Qs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF/FATHnyDx4kXpuDdrKjFESLigVlsCwyIyMGRSOv5o=;
        b=KSyNSRY9TB7VH631HFDh+9e9xSGtY3bSJh1NxXkpqpJEYtfBrdAK8mkF3SXo6gCdqB
         Y4NtXoEn0VpnT6vR20wl4YxOMYfcG3AVldq9B05j2K6uXHsXXV2noRgWlp8ZGHN2ucJe
         ub0Z96dLW0TdiAqjxa6EP69O83fW/3VEmQSY3NAmVkj7cCZP99+cSFNEYsek36qHy+bt
         n52hD478j5DogfCbiPqoa98wC6tEa7t1D0gPT0Mek/mevw6GQk+BfNE2ry6ADiXU0MOM
         0cMWj/1e7T2muquTZsd34x2xqK8dbLdXDQYK0kpj3mX0FT6DToZwCYXUSEjAeB6Iw/ka
         Z/4w==
X-Gm-Message-State: APjAAAXcRB/a6CZ1M2sdQzg9IpOnt4zde3T+WFCd6odH19thE+PiWZeZ
        h13PkQa/P3lBPIjbb4491kJo2x/5sECVPT+pCNQbBg==
X-Google-Smtp-Source: APXvYqxv5qqykKmN0wSDtmvqN3DZS8UYcHJk5gwXPHStya7oU2uHtSU00jGdrstG6DFq0FZM2sY9YdbGgcBqruFHuLQ=
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr5605358otq.236.1562887042322;
 Thu, 11 Jul 2019 16:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7> <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
 <20190625052227.3v74l6xtrkydzx6w@vireshk-i7> <CAGETcx_v05PfscMi2qiYwHRMLryyA_494+h+kmJ3mD+GOjjeLA@mail.gmail.com>
 <20190626063240.kgdiy7xsz4mahrdr@vireshk-i7> <CAGETcx_KH6pqgqZFKddWmgiUX3n+XBU6BoFXkVvPdA4vMDHWsw@mail.gmail.com>
 <20190628064914.4nu6ql7f7h7o4iul@vireshk-i7> <CAGETcx-gSQLtbM+7WgqNvhCypmwoMNjkAkGDqRnK=PUGUOxjkQ@mail.gmail.com>
In-Reply-To: <CAGETcx-gSQLtbM+7WgqNvhCypmwoMNjkAkGDqRnK=PUGUOxjkQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 11 Jul 2019 16:16:46 -0700
Message-ID: <CAGETcx_AiziadEDBrTiXa0qy5dMp3MM=8JLkuESg_SJ4sLZzqQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bump. I saw your email in Sibi's patch series. His patch series is
just one use case/user of this feature. This patch series is useful in
general. Do plan to Ack this? Or thoughts on my earlier response?

Thanks,
Saravana

On Fri, Jun 28, 2019 at 1:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jun 27, 2019 at 11:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 26-06-19, 11:10, Saravana Kannan wrote:
> > > On Tue, Jun 25, 2019 at 11:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > > > So, when a CPU changes frequency, we must change the performance state
> > > > of PM domain and change frequency/bw of the cache synchronously.
> > >
> > > I mean, it's going to be changed when we get the CPUfreq transition
> > > notifiers. From a correctness point of view, setting it inside the OPP
> > > framework is not any better than doing it when we get the notifiers.
> >
> > That's what the problem is. All maintainers now a days ask people to
> > stay away from notifiers and we are making that base of another new
> > thing we are starting.
>
> In that case we can just add direct calls in cpufreq.c to let devfreq
> know about the frequency changes. But then again, CPU is just one
> example for this use case. I'm just using that because people are more
> familiar with that.
>
> > Over that, with many cpufreq drivers we have fast switching enabled
> > and notifiers disabled. How will they make these things work ? We
> > still want to scale L3 in those cases as well.
>
> Nothing is preventing them from using the xlate OPP API I added to
> figure out all the CPU to L3 frequency mapping and then set the L3
> frequency directly from the CPUfreq driver.
>
> Also, whether we use OPP framework or devfreq to set the L3 frequency,
> it's going to block fast switching because both these frameworks have
> APIs that can sleep.
>
> But really, most mobile use cases don't want to permanently tie L3
> freq to CPU freq. Having it go through devfreq and being able to
> switch governors is a very important need for mobile products.
>
> Keep in mind that nothing in this series does any of the cpufreq stuff
> yet. That'll need a few more changes. I was just using CPUfreq as an
> example.
>
> > > I see this as "required for good performance". So I don't see it as
> > > redefining required-opps. If someone wants good performance/power
> > > balance they follow the "required-opps". Technically even the PM
> > > pstates are required for good power. Otherwise, the system could leave
> > > the voltage at max and stuff would still work.
> > >
> > > Also, the slave device might need to get input from multiple master
> > > devices and aggregate the request before setting the slave device
> > > frequency. So I don't think OPP  framework would be the right place to
> > > deal with those things. For example, L3 might (will) have different
> > > mappings for big vs little cores. So that needs to be aggregated and
> > > set properly by the slave device driver. Also, GPU might have a
> > > mapping for L3 too. In which case the L3 slave driver needs to take
> > > input from even more masters before it decides its frequency. But most
> > > importantly, we still need the ability to change governors for L3.
> > > Again these are just examples with L3 and it can get more complicated
> > > based on the situation.
> > >
> > > Most importantly, instead of always going by mapping, one might decide
> > > to scale the L3 based on some other governor (that looks at some HW
> > > counter). Or just set it to performance governor for a use case for
> > > which performance is more important. All of this comes for free with
> > > devfreq and if we always set it from OPP framework we don't give this
> > > required control to userspace.
> > >
> > > I think going through devfreq is the right approach for this. And we
> > > can always rewrite the software if we find problems in the future. But
> > > as it stands today, this will help cases like exynos without the need
> > > for a lot of changes. Hope I've convinced you.
> >
> > I understand the aggregation thing and fully support that the
> > aggregation can't happen in OPP core and must be done somewhere else.
> > But the input can go from OPP core while the frequency is changing,
> > isn't it ?
>
> I'm not opposed to OPP sending input to devfreq to let it know that a
> master device frequency change is happening. But I think this is kinda
> orthogonal to this patch series.
>
> Today the passive governor looks at the master device's devfreq
> frequency changes to trigger the frequency change of the slave
> devfreq. It neither supports tracking OPP frequency change nor CPUfreq
> frequency change. If that's something we want to add, we can look into
> that separately as passive governor (or a new governor) changes.
>
> But then not all devices (CPUfreq or otherwise) use OPP to set the
> frequencies. So it's beneficial to have all of these frameworks as
> inputs for devfreq passive (like) governor. CPUfreq is actually a bit
> more tricky because we'll also have to track hotplug, etc. So direct
> calls from CPUfreq to devfreq (similar to cpufreq stats tracking)
> would be good.
>
> -Saravana
