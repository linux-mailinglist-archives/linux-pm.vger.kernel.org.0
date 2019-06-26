Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA73D57055
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZSLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 14:11:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43781 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZSLN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 14:11:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so2641713oif.10
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkYbiSTWGK4F/ssJpkJ5iQHzwJyTPwJlwzmqFVyv6BQ=;
        b=IuX+cTrj8KVC0cjl5SAn479N9pAU8DQxPrzzBE+KeOgtp8IO5vGkZoo1b6DtkqQLW7
         6d21Jp6rpnZE3YnpLVUDlJygM5ZIPZlWxbbuV79pzXHAn2m5bg+kQvN7kVFbCOHqgfEn
         ELvbPLt/+puWfg4cbzmOiQpoCZCPPsiZR0y1xlsubLcwQ43nAITH4V1GlTzlB3wHQxDe
         F/j9RQrTRQHFaRj7jH7xor95S7V/3GsJBVxxoabmshKHoKkoakQJUdlHUspv+PvenKc+
         FsQeVckFhUWOdReLOnM4M1KbXZmssJ+8quAAYgF1U2WwybZVQiG/kitFssW3aagmzrld
         cfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkYbiSTWGK4F/ssJpkJ5iQHzwJyTPwJlwzmqFVyv6BQ=;
        b=oLJQ0rDVKZV9VAGjE0QR95AT5F3sLRdRmd4HmHZeBBZ/s8YZtGk6Q0p7KTr/Uxy9Jp
         l+rltqgx/qhJys3PMNxZrf4aIm2Xbo/xFkxgBa1Tler5J0GLt+GE9X+uKGracvgRtdlf
         92CdrwbEU22l/zitNcufN/dtzZS+0EDFffCC6BsE7IG9yyIdo3dS2fP1f5YMPtypbMNY
         cUv/4Sg8Y1OQEs72cuL7uCNTasvnvrbYoKjk9gWewhljrxN4KGc+NvzqEOz8uPyAyuBW
         mZMjzIUdV+uNJ6QlD/6ynsdtepFYX41F6t5OVk3rfak6B9+toXAshV2nJ/m+bQU+apOX
         +9LQ==
X-Gm-Message-State: APjAAAWNxm326e4tGi1fIE+kTjgW1PqUEHhzELI5eNqFuXnC9E2J7eea
        y2qYg9dZ3zLMVjcaMUFQo1YWLaHfdQSFVDmZRQ6c9g==
X-Google-Smtp-Source: APXvYqxTQuBLL+L0U/juwb7BvplBxisurDryI9LUdGwEANvm3S6wL+EqZeE03RTA0braPBtM9FtG2WhZRrHDETTfsbM=
X-Received: by 2002:a05:6808:6c7:: with SMTP id m7mr221316oih.43.1561572667875;
 Wed, 26 Jun 2019 11:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7> <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
 <20190625052227.3v74l6xtrkydzx6w@vireshk-i7> <CAGETcx_v05PfscMi2qiYwHRMLryyA_494+h+kmJ3mD+GOjjeLA@mail.gmail.com>
 <20190626063240.kgdiy7xsz4mahrdr@vireshk-i7>
In-Reply-To: <20190626063240.kgdiy7xsz4mahrdr@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 26 Jun 2019 11:10:31 -0700
Message-ID: <CAGETcx_KH6pqgqZFKddWmgiUX3n+XBU6BoFXkVvPdA4vMDHWsw@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 11:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-06-19, 22:29, Saravana Kannan wrote:
> > No, the CPUs will be the "parent" and the cache will be the "child".
> > CPU is a special case when it comes to the actual software (not DT) as
> > we'll need the devfreq governor to look at all the CPUfreq policies to
> > decide the cache frequency (max of all their requirements).
> >
> > I think "master" and "slave" would have been a better term as the
> > master device determines its frequency using whatever means and the
> > "slave" device just "follows" the master device.
>
> Okay, so to confirm again this is what we will have:
>
> - CPUs are called masters and Caches are slaves.
>
> - The devfreq governor we are talking about takes care of changing
>   frequency of caches (slaves) and chooses a target frequency for
>   caches based on what the masters are running at.
>
> - The CPUs OPP nodes will have required-opps property and will be
>   pointing to the caches OPP nodes. The CPUs may already be using
>   required-opps node for PM domain performance state thing.
>
>
> Now the problem is "required-opp" means something really *required*
> and it is not optional.

But we could interpret it as "required" for different things.

> Like a specific voltage level before we can
> switch to a particular frequency.

Required for stability.

> And this is how I have though of it
> until now. And this shouldn't be handled asynchronously, i.e. required
> OPPs must be set while configuring OPP of a device.

The users of clocks are expected to set up the voltage correctly
before changing the frequency, the drivers are expected to power up
the device before trying to access its registers, etc. So I don't
think there is one correct way. Also OPP sets the pstate only if
dev_pm_opp_set_genpd_virt_dev() has been called to set them up. So
this is not a mandatory principle in the kernel that a framework
providing an API should have all the dependencies. So I don't think
we'll be violating some golden rule.

> So, when a CPU changes frequency, we must change the performance state
> of PM domain and change frequency/bw of the cache synchronously.

I mean, it's going to be changed when we get the CPUfreq transition
notifiers. From a correctness point of view, setting it inside the OPP
framework is not any better than doing it when we get the notifiers.

> And
> in such a case "required-opps" can be a very good fit for this use
> case.

Glad you agree :)

> But with what you are trying to do it is no longer required-opp but
> good-to-have-opp. And that worries me.

I see this as "required for good performance". So I don't see it as
redefining required-opps. If someone wants good performance/power
balance they follow the "required-opps". Technically even the PM
pstates are required for good power. Otherwise, the system could leave
the voltage at max and stuff would still work.

Also, the slave device might need to get input from multiple master
devices and aggregate the request before setting the slave device
frequency. So I don't think OPP  framework would be the right place to
deal with those things. For example, L3 might (will) have different
mappings for big vs little cores. So that needs to be aggregated and
set properly by the slave device driver. Also, GPU might have a
mapping for L3 too. In which case the L3 slave driver needs to take
input from even more masters before it decides its frequency. But most
importantly, we still need the ability to change governors for L3.
Again these are just examples with L3 and it can get more complicated
based on the situation.

Most importantly, instead of always going by mapping, one might decide
to scale the L3 based on some other governor (that looks at some HW
counter). Or just set it to performance governor for a use case for
which performance is more important. All of this comes for free with
devfreq and if we always set it from OPP framework we don't give this
required control to userspace.

I think going through devfreq is the right approach for this. And we
can always rewrite the software if we find problems in the future. But
as it stands today, this will help cases like exynos without the need
for a lot of changes. Hope I've convinced you.

-Saravana
