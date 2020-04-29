Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BF1BD9DB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgD2Kkc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:40:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34927 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2Kkb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:40:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id o7so1377142oif.2;
        Wed, 29 Apr 2020 03:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwYHZCwTFZHdWBfKehSRrwQ6RP1rkz42njkLhrO7AEs=;
        b=MjyEHs3RSThMKKqH7zzt/CpUdrps5kzRbeNvtLs0MvKVDycNcpfhanewgpV53gmsg+
         F0ZscscjawNBj4flUeZk6vY7crgY5ih7V8iQLGKzn5/v7poEI0ep0YKpKQxgKtgCiA8C
         v6M6pMo5+oFw5FnRJBSzcCixx0CTJGFvP9ELnjUKXW7W/L8sVIqUYM9IsAtfIOR36BLo
         8XrBeKQ1VpUwQ5uTXSAtCzaFiazxEr+okxVvjuFHs22QV1JVbKWmenSWeFAf3gIBZWyX
         MLd09jA/aptiIlQUyeF57k43Uw1VEt6zMqZDb5KgqKtRRitpwYMFFr16RvBl4Lph/0XU
         cMzw==
X-Gm-Message-State: AGi0Puaj91SYy1njCo52BKhxVT4t5Q2kTHv0N6Uh+rxA/NCdfPabqRuK
        Nw9Rw/+cn9XpiKv3eiXa5SBQnDcM8vzMQ+j43q8=
X-Google-Smtp-Source: APiQypIqWwv23xpZxpst75bnUokzIBvD1oGXEBXTWbJS9ozxi6Cp/PWGkFX/Vu6ygQLosqRi7GjMeocP2TTEzA79Gds=
X-Received: by 2002:aca:c441:: with SMTP id u62mr1231257oif.110.1588156829763;
 Wed, 29 Apr 2020 03:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200409112742.3581-1-qais.yousef@arm.com> <26038947.HFycnDbHsR@kreacher>
 <20200427102910.b6iysyumiz5pj4sv@e107158-lin>
In-Reply-To: <20200427102910.b6iysyumiz5pj4sv@e107158-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 12:40:18 +0200
Message-ID: <CAJZ5v0gesatUBMdt0c30tg34mTeFOon=7ntzQq88=tfJLy8CtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "cpu/hotplug: Ignore pm_wakeup_pending() for disable_nonboot_cpus()"
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 12:29 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/26/20 17:24, Rafael J. Wysocki wrote:
> > I would do this the other way around:
> >
> > 1. Make x86 call freeze_secondary_cpus() directly, rename
> >    enable_nonboot_cpus() and drop disable_nonboot_cpus().
>
> All of this in a single patch?

Well, why not?

Calling freeze_secondary_cpus() directly causes disable_nonboot_cpus()
to be unused (and so it can be dropped in the same patch) and it also
introduces a name mismatch between freeze_ and enable_, which IMO
needs to be addressed right away (also in the same patch).

> > 2. Get rid of __freeze_secondary_cpus().
>
> I guess you're implying to drop the revert too and manually unroll it instead.

IMO the revert is just an extra step with no real value, so why do it?

> Could do.

Thanks!
