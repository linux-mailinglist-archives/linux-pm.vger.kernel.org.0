Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBA209DC1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbgFYLx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 07:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgFYLxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 07:53:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC69C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 04:53:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so4135426wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L4pFCzHJgLhT16AIpG64Yl9/rDj1/+gYvG4jvCw9F50=;
        b=n3FRfqC1licA7sUvOVNsmYWGO4K/7vUEPRhyqo4fBRqJTuRXkEEQHh7uwPCnN+FcSf
         ENydElYHJy9PUQYU9sfu1loBq5H0SIftbO5Sht4ahrm0xfMnJWRT8ci/38Brp/clygPK
         L+kiUfWAo1teGmyfYs8LGk4Be7IorgzrIWkIJkU3+o97MGk2rpkBjG0TTaRxtyGh3tTs
         EeCP+GkZCM3t1EJHFzQFkTYrnf8HsuUcHNDQc4lZ7iWF+4scXEzFr1ns/1MxaOcUwWTj
         JPmiymJ2xlffeNK125ctWiPcqf8r9RQ46JpCxIewZ2tZTAghyq1qmdPz+xuCXqYbiZRg
         gZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4pFCzHJgLhT16AIpG64Yl9/rDj1/+gYvG4jvCw9F50=;
        b=P1lQVwCBt31eB+/5CE4KbBiBUSdgu94Rby0Ij+0QRcAHv4w5/MZR3uPtzVKT62/LNl
         KDp/H3r3PsEURnf8ZBWsL7QeXbNDumTFBjCAG8IcKt68XhA66ZDbCSLIM+zT8/U29ISM
         XGrqfdMWaRY7uSxvxNA/JaRZGAqjBIvUi9njY0JvEYCu8J+cx7hbKb73G/EAZUw19eD2
         zKngWub82ygU/dbFHXLaGLUTjo1HDUZ21bynAmRXw/cfqIe0+MYnZ2xuOqSvloG19jC+
         WzXtAg2T0UYc2ppOlU1BBRXnmx1XZ6CZVgWsstys75cWWiHXr8BgNY5iwgU0Va//LQhO
         8Qow==
X-Gm-Message-State: AOAM533lxNvD5PvCee/z5uZXzWzrVYim/Em2fMsv4fkWnh5WzidpWmx7
        PSaW/OwkLhL6ACGaq6j0mIzObQ==
X-Google-Smtp-Source: ABdhPJzB3iG4QLOlxIPODy0q2tWS2+hoPSsNM/MppS52ewBi9bFqIsOWO5K4QEbJ3JGH6DNum7H2Og==
X-Received: by 2002:a1c:2d54:: with SMTP id t81mr3196690wmt.154.1593086002391;
        Thu, 25 Jun 2020 04:53:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 104sm32104033wrl.25.2020.06.25.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:53:21 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:53:18 +0100
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
Message-ID: <20200625115318.GA219598@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200625113602.z2xrwebd2gngbww3@vireshk-i7>
 <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=+2OFKVk2ZnmK-33knUwqcaOOQ+q9ZWnmeoBD9KOX9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 25 Jun 2020 at 13:44:34 (+0200), Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2020 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > This change is not right IMO. This part handles the set-policy case,
> > where there are no governors. Right now this code, for some reasons
> > unknown to me, forcefully uses the default governor set to indicate
> > the policy, which is not a great idea in my opinion TBH. This doesn't
> > and shouldn't care about governor modules and should only be looking
> > at strings instead of governor pointer.
> 
> Sounds right.
> 
> > Rafael, I even think we should remove this code completely and just
> > rely on what the driver has sent to us. Using the selected governor
> > for set policy drivers is very confusing and also we shouldn't be
> > forced to compiling any governor for the set-policy case.
> 
> Well, AFAICS the idea was to use the default governor as a kind of
> default policy proxy, but I agree that strings should be sufficient
> for that.

I agree with all the above. I'd much rather not rely on the default
governor name to populate the default policy, too, so +1 from me.

Thanks,
Quentin
