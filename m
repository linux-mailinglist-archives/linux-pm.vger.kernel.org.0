Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94DB207771
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgFXPdF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404336AbgFXPdF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:33:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD34C061573
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 08:33:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so2728995wrw.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tjbKj2JJLg9M2F9CwUzFaqxTadc+FoDJkeC9qG6WPMU=;
        b=NdGWSeURe89L687lK6viNqICXEaDJjfaGLPwujuLMFiZJ1aDEkLa12K2oxn2S2WIEs
         hkB1pY5if8CE4WN9vmXx0Rt76OtQhGpcgWLvBb3iCCJ+YzMa0+YAGQrTgNniCwPaxZzD
         jLe8XHBoU9Ood6I/yiYOC9k11zyPlMZk0dUuHGDNPIwkrxoAHyHWrD4UMCeRIoTCkV1w
         o8esn5pXHLSpajx8K6CJdbsk9mY5zOIDBMYBBT8F6zfWUR3it3aKHnDkkm8x688uoyBW
         Fbr4PQoeJ2PrJiLw0o2n+X26nm/5PKbIN4tjB76F5y9DL3ehSR9YWAes/eksf5KbWiQ5
         bL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjbKj2JJLg9M2F9CwUzFaqxTadc+FoDJkeC9qG6WPMU=;
        b=kTvV7OxaRE+2cqY5y0okD+WX55KHazBIx0W00zH/y5+js+kGhEYwg6ra0ayz/jNU7E
         6Up4Fg9PFuPvHv2xoLDjhlNa7M/M/MQXR8WCKmi7x07J9YKzWuehm6B9ISPPv/mEvMSo
         eXK/a1Vl312DGFc3BPPLJcSW14A8zFkJ3WZhky3Iy4GtVLaWTtQWp5VrNH+ewUYz3pkD
         +MBSBMV00Jm0POE7zb23cO2/dCG7d7EzzCdYMXH/Ux+Z9U6BMIYz/vu0ksswmpiDccFZ
         TuiYOu9nbzBKK8RWC4dkyUOIVIbOSBzxDdma+A4pqBfFof6QjAUgduk9t3nnJ0Hvpp1E
         DK8A==
X-Gm-Message-State: AOAM532gxAceo3jUfZU6Z3kr+QMuF/pSw+zw9Ca6kOGhs7lQ9TiHy5B1
        plAC80A1xVfjAqXge471cykfHA==
X-Google-Smtp-Source: ABdhPJzSLr689rNCk/afvTQhZdA+AJuwcms9tOdw/Vdl7nFAHHPTyyLyGmG/dH9YWD0knsSg2tqB1A==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr20640246wrw.204.1593012783030;
        Wed, 24 Jun 2020 08:33:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id z6sm4359909wmf.33.2020.06.24.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:33:02 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:32:59 +0100
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
Message-ID: <20200624153259.GA2844@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200624055023.xofefhohf7wifme5@vireshk-i7>
 <CAJZ5v0ja_rM7i=psW1HRyzEpW=8QwP2u9p+ihN3FS8_53bbxTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ja_rM7i=psW1HRyzEpW=8QwP2u9p+ihN3FS8_53bbxTQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 24 Jun 2020 at 14:51:04 (+0200), Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2020 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > @@ -2789,7 +2796,13 @@ static int __init cpufreq_core_init(void)
> > >       cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> > >       BUG_ON(!cpufreq_global_kobject);
> > >
> > > +     mutex_lock(&cpufreq_governor_mutex);
> > > +     if (!default_governor)
> > > +             default_governor = cpufreq_default_governor();
> > > +     mutex_unlock(&cpufreq_governor_mutex);
> >
> > I don't think locking is required here at core-initcall level.
> 
> It isn't necessary AFAICS, but it may as well be regarded as
> annotation (kind of instead of having a comment explaining why it need
> not be used).

Right, but I must admit that, looking at this more, I'm getting a bit
confused with the overall locking for governors :/

When in cpufreq_init_policy() we find a governor using
find_governor(policy->last_governor), what guarantees this governor is
not concurrently unregistered? That is, what guarantees this governor
doesn't go away between that find_governor() call, and the subsequent
call to try_module_get() in cpufreq_set_policy() down the line?

Can we somewhat assume that whatever governor is referred to by
policy->last_governor will have a non-null refcount? Or are the
cpufreq_online() and cpufreq_unregister_governor() path mutually
exclusive? Or is there something else?

Thanks,
Quentin
