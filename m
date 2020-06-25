Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AD220A04C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405158AbgFYNuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYNuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 09:50:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48BEC08C5DB
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 06:49:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so6017368wml.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Km4XU3YCbQ1BlBaA5eguEzAMNhTjDSRuzkyQ4wjQ+Y=;
        b=FycxCHPiF4RsALIYh3iW+vhK/8NZBacCDA43aqRb5syfhW0lXroapFe7s7rNPJMH3L
         YJS5H3RrUA+/TxEJL5OEczu34Ql+7GwHaA6dPKjQHLOTvISFnLJULaNOFfzac2Yceqci
         Zp4amK8Gq63zXqgZQV3hT6NxwTa+d7H7DwLslCPYrO99etQ1IY9p57wNaheJved0wTsp
         ouPsbJ57kviReSPXQ7BpXAxXpmLGwWUtGi52hgzrfGIZ7oCe1n44I+5+Bf2u+na6amXE
         QQoikQ6kttKR73fDOSUPwEzx3XLMrmMo12J8YfINSK/x2EqM22GES5moEwSTzOeozHBD
         vQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Km4XU3YCbQ1BlBaA5eguEzAMNhTjDSRuzkyQ4wjQ+Y=;
        b=kGBy6Tvg9eqlGJ2qW3tXEVibUiFeJ5Lnd3X10ihKfapSbTaEo+qUCuqtU88rtfyFYk
         XdmAAiESFdBRMVUVp71z7DTwHAFmEcamdgU0emsyQeGikwMfdmwHChV1DwnPXnvLDjjX
         F46ThLYGjp/UcPK9JwmHgu1ovobI8x3tu+pNINK9CVCYzkk/ftmyDQYytHLELO09zRXa
         Qs7QwR+bwabrPU8xMIfWOPoNkHT1pOadl0QTYb8bFxRW0EXtmKSnSBZdKc2ywG7hAg5x
         yhMw+PbSfZv4nLHlgpAM78sWnc1Thzi0SCOHjhbKyhCLyxXPCRpCWBBQW1ezCz6vw/OA
         kqOQ==
X-Gm-Message-State: AOAM532KoehJTB/kF9bCYQq0y+h0HbZQ2volZuq4Apjw/UVgy0w5vS3g
        TUvQ65gkXgS1n1F99tHNzt9zbw==
X-Google-Smtp-Source: ABdhPJxecS3KmUscrOmXn/iaNXCbUj7dNrZNCXj7EKIp3bTt9cpi2niiXt7IGvLyLr8T+9KW/8WsAg==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr3301080wmn.167.1593092997450;
        Thu, 25 Jun 2020 06:49:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 67sm33021937wrk.49.2020.06.25.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:49:56 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:49:53 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
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
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200625134953.GA242742@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
 <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
 <20200625115318.GA219598@google.com>
 <CAJZ5v0jQkeu5dJXxXN2eQ+cAwv8oSK_wZZgTW3cvMZX0ks9jHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jQkeu5dJXxXN2eQ+cAwv8oSK_wZZgTW3cvMZX0ks9jHQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 25 Jun 2020 at 15:28:43 (+0200), Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2020 at 1:53 PM Quentin Perret <qperret@google.com> wrote:
> >
> > On Thursday 25 Jun 2020 at 13:44:34 (+0200), Rafael J. Wysocki wrote:
> > > On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > This change is not right IMO. This part handles the set-policy case,
> > > > where there are no governors. Right now this code, for some reasons
> > > > unknown to me, forcefully uses the default governor set to indicate
> > > > the policy, which is not a great idea in my opinion TBH. This doesn't
> > > > and shouldn't care about governor modules and should only be looking
> > > > at strings instead of governor pointer.
> > >
> > > Sounds right.
> > >
> > > > Rafael, I even think we should remove this code completely and just
> > > > rely on what the driver has sent to us. Using the selected governor
> > > > for set policy drivers is very confusing and also we shouldn't be
> > > > forced to compiling any governor for the set-policy case.
> > >
> > > Well, AFAICS the idea was to use the default governor as a kind of
> > > default policy proxy, but I agree that strings should be sufficient
> > > for that.
> >
> > I agree with all the above. I'd much rather not rely on the default
> > governor name to populate the default policy, too, so +1 from me.
> 
> So before this series the default governor was selected at the kernel
> configuration time (pre-build) and was always built-in.  Because it
> could not go away, its name could be used to indicate the default
> policy for the "setpolicy" drivers.
> 
> After this series, however, it cannot be used this way reliably, but
> you can still pass cpufreq_param_governor to cpufreq_parse_policy()
> instead of def_gov->name in cpufreq_init_policy(), can't you?

Good point. I also need to fallback to the default builtin governor if
the command line parameter isn't valid (or non-existent), so perhaps
something like so?

iff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dad6b85f4c89..20a2020abf88 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -653,6 +653,23 @@ static unsigned int cpufreq_parse_policy(char *str_governor)
        return CPUFREQ_POLICY_UNKNOWN;
 }
 
+static unsigned int cpufreq_default_policy(void)
+{
+       unsigned int pol;
+
+       pol = cpufreq_parse_policy(cpufreq_param_governor);
+       if (pol != CPUFREQ_POLICY_UNKNOWN)
+               return pol;
+
+       if (IS_BUILTIN(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE))
+               return CPUFREQ_POLICY_PERFORMANCE;
+
+       if (IS_BUILTIN(CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE))
+               return CPUFREQ_POLICY_POWERSAVE;
+
+       return CPUFREQ_POLICY_UNKNOWN;
+}
+
 /**
  * cpufreq_parse_governor - parse a governor string only for has_target()
  * @str_governor: Governor name.
@@ -1085,8 +1102,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
                /* Use the default policy if there is no last_policy. */
                if (policy->last_policy) {
                        pol = policy->last_policy;
-               } else if (default_governor) {
-                       pol = cpufreq_parse_policy(default_governor->name);
+               } else {
+                       pol = cpufreq_default_policy();
                        /*
                         * In case the default governor is neiter "performance"
                         * nor "powersave", fall back to the initial policy
