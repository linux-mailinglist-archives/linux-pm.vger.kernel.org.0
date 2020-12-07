Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88C2D1259
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLGNl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:41:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33642 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGNl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:41:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so12469595ots.0;
        Mon, 07 Dec 2020 05:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sajsa5hnD4/l7bV/fF2j2mLOSef/O2Ms1lr8tdESjSo=;
        b=K/w/A7eLcqbSNTzQIZKEt83wwglQ241ARxP16ueFuuRJ5pAX6KC9Kqbo42Kn3gB/K7
         yJSUGkapkoIyd6tm1uQTUAehOU124VhgFA5LPlv8IoY6SNKib8dFHC9hnzUrfXwfYq4v
         CdzUWeBRSDGfpQcmtpegHw4bnhfLZ/PBRSPFKI+nV9XSSRRZ7HikYux6hA28/K28yDqm
         nuY0WdLdqfJezLZM93IZ/Xyk4k4yuRVKVzVSxvhcyJ8t7PyZE7AGuSIOyJss1RBIHhT+
         ND/j8Ro4CUaf1vG/OAclmFjy33lyU4NPi7rdB0g7GcaJ5Cwn2p2CG7pOs4oPev1YphuE
         o33A==
X-Gm-Message-State: AOAM532RuwTrjzdh+t3U+07Xk+CxvU7penk9LipqH0AhgzPHaYtvO55e
        5U4vgsepMNMefdaW7ziljjQ6Y2CtCEqBonQCzwo=
X-Google-Smtp-Source: ABdhPJx3dLzEghwd0BjIRF1O1W3UAcd1cMqWifXAspvtKG8rUP90q4qF3kjF3M3XCqG2meUkVW9siofXR2718aVuTcA=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr6057544otn.321.1607348469598;
 Mon, 07 Dec 2020 05:41:09 -0800 (PST)
MIME-Version: 1.0
References: <1817571.2o5Kk4Ohv2@kreacher> <2174134.tL5yAn4CWt@kreacher> <20201207074615.kmvy5afoolhv5cgq@vireshk-i7>
In-Reply-To: <20201207074615.kmvy5afoolhv5cgq@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 14:40:52 +0100
Message-ID: <CAJZ5v0havcy_SZ6yUqjn4KK8=8SMJRSkhgaTm==eMeEinxDN2w@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching
 callback for drivers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 7, 2020 at 8:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-11-20, 19:37, Rafael J. Wysocki wrote:
> > Index: linux-pm/include/linux/cpufreq.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -320,6 +320,15 @@ struct cpufreq_driver {
> >                                       unsigned int index);
> >       unsigned int    (*fast_switch)(struct cpufreq_policy *policy,
> >                                      unsigned int target_freq);
> > +     /*
> > +      * ->fast_switch() replacement for drivers that use an internal
> > +      * representation of performance levels and can pass hints other than
> > +      * the target performance level to the hardware.
> > +      */
> > +     void            (*adjust_perf)(unsigned int cpu, bool busy,
>
> Maybe this should still take policy as an argument (like other calls)
> instead of CPU, even if it is going to be used for single-cpu per
> policy case for now.

That can be changed in the future if need be.

Otherwise this path doesn't need to look at the policy object at all
and I'd rather keep it this way.

>
> > +                                    unsigned long min_perf,
> > +                                    unsigned long target_perf,
> > +                                    unsigned long capacity);
>
> --
