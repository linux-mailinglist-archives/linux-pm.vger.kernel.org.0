Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC61620A095
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405244AbgFYOIa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 10:08:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42742 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbgFYOIa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 10:08:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id t6so5338628otk.9;
        Thu, 25 Jun 2020 07:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1G0Ez0jA0KKuMLKX/f3wLMblA8vWgfaiNzP5I6+jGk=;
        b=aK3lBukc7zs2n5uRHmm10ETi0VTasx8FLZFbDljgQ8Qi7ETg3j8aMBBGCe30NP7umr
         +eu7J+sTghaBEbGz9ftPnjGhd7FE5ztMXu2zhOvWg11jbZTjar3yS7uKmxaagyBl4nLI
         hDTa0bW6furyrKkS/fNH0CKvh4RX44ssIZOziUUGZZEqVzh5GWG1Zw7zJMWYKYSOCsGx
         /xlpee3cFvZaPeI9Fq8l/VPne3uNgTzG7GVuxLp080kt7uMBE4vwbAtcEYWOdeBGK+6A
         IYNHcf7UbC7GgNOL16XRvaSO3N8rsibDYy4HTVbWXr7uXJwsyXeSZ7pTJN8rOFM1p7D3
         9qlw==
X-Gm-Message-State: AOAM533CJqrxBpzzTE1OiPPvxNAwKiFIkr/nrLeEwT2foBAWmKBUILWW
        +Qmu/LhBs8MDM5k1v41RfoiVJtFg50xZXCTCD30=
X-Google-Smtp-Source: ABdhPJwQf1p7c/AXGZmwgxwwEMmerXk7khBfNnfyYqWCY5frEiveZRVNhDq2zcxvgennBXiVTqJDg1dcwqTyyOrWhQI=
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr26064118oto.167.1593094109209;
 Thu, 25 Jun 2020 07:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200623142138.209513-1-qperret@google.com> <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7> <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
 <20200625115318.GA219598@google.com> <CAJZ5v0jQkeu5dJXxXN2eQ+cAwv8oSK_wZZgTW3cvMZX0ks9jHQ@mail.gmail.com>
 <20200625134953.GA242742@google.com>
In-Reply-To: <20200625134953.GA242742@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 16:08:18 +0200
Message-ID: <CAJZ5v0iRSJgZ3H4rUJBzDB-gTvKUcyo0eubQm=wjKnGq0DBH2g@mail.gmail.com>
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

On Thu, Jun 25, 2020 at 3:50 PM Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 25 Jun 2020 at 15:28:43 (+0200), Rafael J. Wysocki wrote:
> > On Thu, Jun 25, 2020 at 1:53 PM Quentin Perret <qperret@google.com> wrote:
> > >
> > > On Thursday 25 Jun 2020 at 13:44:34 (+0200), Rafael J. Wysocki wrote:
> > > > On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > This change is not right IMO. This part handles the set-policy case,
> > > > > where there are no governors. Right now this code, for some reasons
> > > > > unknown to me, forcefully uses the default governor set to indicate
> > > > > the policy, which is not a great idea in my opinion TBH. This doesn't
> > > > > and shouldn't care about governor modules and should only be looking
> > > > > at strings instead of governor pointer.
> > > >
> > > > Sounds right.
> > > >
> > > > > Rafael, I even think we should remove this code completely and just
> > > > > rely on what the driver has sent to us. Using the selected governor
> > > > > for set policy drivers is very confusing and also we shouldn't be
> > > > > forced to compiling any governor for the set-policy case.
> > > >
> > > > Well, AFAICS the idea was to use the default governor as a kind of
> > > > default policy proxy, but I agree that strings should be sufficient
> > > > for that.
> > >
> > > I agree with all the above. I'd much rather not rely on the default
> > > governor name to populate the default policy, too, so +1 from me.
> >
> > So before this series the default governor was selected at the kernel
> > configuration time (pre-build) and was always built-in.  Because it
> > could not go away, its name could be used to indicate the default
> > policy for the "setpolicy" drivers.
> >
> > After this series, however, it cannot be used this way reliably, but
> > you can still pass cpufreq_param_governor to cpufreq_parse_policy()
> > instead of def_gov->name in cpufreq_init_policy(), can't you?
>
> Good point. I also need to fallback to the default builtin governor if
> the command line parameter isn't valid (or non-existent), so perhaps
> something like so?

Yes, that should work if I haven't missed anything.

> iff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index dad6b85f4c89..20a2020abf88 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -653,6 +653,23 @@ static unsigned int cpufreq_parse_policy(char *str_governor)
>         return CPUFREQ_POLICY_UNKNOWN;
>  }
>
> +static unsigned int cpufreq_default_policy(void)
> +{
> +       unsigned int pol;
> +
> +       pol = cpufreq_parse_policy(cpufreq_param_governor);
> +       if (pol != CPUFREQ_POLICY_UNKNOWN)
> +               return pol;
> +
> +       if (IS_BUILTIN(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE))
> +               return CPUFREQ_POLICY_PERFORMANCE;
> +
> +       if (IS_BUILTIN(CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE))
> +               return CPUFREQ_POLICY_POWERSAVE;
> +
> +       return CPUFREQ_POLICY_UNKNOWN;
> +}
> +
>  /**
>   * cpufreq_parse_governor - parse a governor string only for has_target()
>   * @str_governor: Governor name.
> @@ -1085,8 +1102,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>                 /* Use the default policy if there is no last_policy. */
>                 if (policy->last_policy) {
>                         pol = policy->last_policy;
> -               } else if (default_governor) {
> -                       pol = cpufreq_parse_policy(default_governor->name);
> +               } else {
> +                       pol = cpufreq_default_policy();
>                         /*
>                          * In case the default governor is neiter "performance"
>                          * nor "powersave", fall back to the initial policy
