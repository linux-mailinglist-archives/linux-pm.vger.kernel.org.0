Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852B0209FE2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404872AbgFYN2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 09:28:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44391 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404829AbgFYN2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 09:28:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id 5so3223002oty.11;
        Thu, 25 Jun 2020 06:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OV4WC/OGzJxfoXBFjW4vy0msSEZBQa3DQSv+ctqbI9s=;
        b=DhoQHM/jsiatijZOLs1g04di4YZlWR0EWuUZi7fCOgrQdIzkch18B46zmWYEqSTIea
         vOMSIQCH5aUwfzy0GzSK+ZkU4ImvBcW0EywzGJm50UmLn3/uY47qujrmFrUIF9cJjkyj
         c0Nsj60srsbHOB2uCTMGbDXute1G0Hs2z2bdPDULOaqy7WBU4Dx/hYzVEn4DO6ynv3PS
         EBV010anE46Io4xaB1/X8o1yx/u2NqWRw6NcSLa6C0jB2jkWc51VRGQ6xrNdba5o+mP7
         2AwjSe3Uk7G5EEzlDKhBDZhBn4vqLck16D7zewZzFrnFhYHh5v1jmpLrlK/tXH84C30f
         Gj/Q==
X-Gm-Message-State: AOAM532f9iw0HwZz59vsi43gjKI0cUjarM7tTUMrt5Y71QYMakepH9L7
        kzSLDXU6CAGFNB9YKc4FjicaypZlr1VZJQCMYp8=
X-Google-Smtp-Source: ABdhPJxlUXOc9imwl9lPejVNcyeUZKKYcc4bvi+l4uR/l8F3vA3oLuAVU6XT/a0cSQMG33eUfVPp/S664VWlHO/mRZ4=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr25888354otn.118.1593091734743;
 Thu, 25 Jun 2020 06:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142138.209513-1-qperret@google.com> <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7> <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
 <20200625115318.GA219598@google.com>
In-Reply-To: <20200625115318.GA219598@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 15:28:43 +0200
Message-ID: <CAJZ5v0jQkeu5dJXxXN2eQ+cAwv8oSK_wZZgTW3cvMZX0ks9jHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
To:     Quentin Perret <qperret@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 1:53 PM Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 25 Jun 2020 at 13:44:34 (+0200), Rafael J. Wysocki wrote:
> > On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > This change is not right IMO. This part handles the set-policy case,
> > > where there are no governors. Right now this code, for some reasons
> > > unknown to me, forcefully uses the default governor set to indicate
> > > the policy, which is not a great idea in my opinion TBH. This doesn't
> > > and shouldn't care about governor modules and should only be looking
> > > at strings instead of governor pointer.
> >
> > Sounds right.
> >
> > > Rafael, I even think we should remove this code completely and just
> > > rely on what the driver has sent to us. Using the selected governor
> > > for set policy drivers is very confusing and also we shouldn't be
> > > forced to compiling any governor for the set-policy case.
> >
> > Well, AFAICS the idea was to use the default governor as a kind of
> > default policy proxy, but I agree that strings should be sufficient
> > for that.
>
> I agree with all the above. I'd much rather not rely on the default
> governor name to populate the default policy, too, so +1 from me.

So before this series the default governor was selected at the kernel
configuration time (pre-build) and was always built-in.  Because it
could not go away, its name could be used to indicate the default
policy for the "setpolicy" drivers.

After this series, however, it cannot be used this way reliably, but
you can still pass cpufreq_param_governor to cpufreq_parse_policy()
instead of def_gov->name in cpufreq_init_policy(), can't you?
