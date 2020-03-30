Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89556197C8A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 15:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgC3NLo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 09:11:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbgC3NLo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 09:11:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id a24so1712441pfc.8;
        Mon, 30 Mar 2020 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJ3TyvoFApvA3YeewIwlAIGLD0UIZM7kn/bRRvcTrjw=;
        b=O0ZaJzjrsqaH8T7T/ksePnAm/NlJO+6qoptcFKLvEEgtxL5EtsV3CEpPxql6m4tpM8
         6yN9iaczQ72XGuSQ4pjvRedRyRr18nJDix84RYE7+DJoArG8KgOkSbOv5IUieg6EcQ5g
         guV2pClmvSsZ+bRlVwvjlyTPEG0N+CLkTjepcuhRamuJ05N3vVn0kg59vjM1VssGt9ai
         y0GLKKgKLFhgRCEWYPX1HOzeXcujs5m/qZ8AMV//Cc87NCWXJU7v5uY7ZScfZw/x+HTS
         T1y7hjgVMs3ZCp59wqnZckfhASiUOJDua1WoButL2R1sWItDpSZGb3FVWvHt5qLtQtBz
         g50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJ3TyvoFApvA3YeewIwlAIGLD0UIZM7kn/bRRvcTrjw=;
        b=eAlTa/rQXIlqfR15R0T9YpGMM74cMotERgZcprPptm2282hPCXavPvHBT0diOdQZNc
         FMmu/D6hwi9E84a0ycNXl4w2Tr+jNReEG41Yv6vYDkKpPnDa0Y+ayXp8iOym2NNIMy1p
         B3JO/7LbzremQouH99r+LtT9wP6jFLWIl/DqZf7fXuGldnPUfsNAJK/5/n4j6d9TPRw2
         GjuEWd5Tp3IYwC2Jrh1MBkCWlxSmvsDxUzG9o5YrU3+FZZyBkOEZjemoFOoanWtbOZ6H
         y7ax1xAwOszHT8llXwU0TuJHLBc8snbgr5JSbHK/xSI86k2HEN09vjbwQHJxxRhOe9m5
         nO/A==
X-Gm-Message-State: ANhLgQ1qolmArYLZQHvNuz70MxDo5BN1qKT7RK9BVCBgIKv1I3Qw4/fT
        Ps2qILOuFxlUUp2m1A9Ca7ODBe7pxgAl5UG8tD8=
X-Google-Smtp-Source: ADFU+vt/wdF9Yz9aLGwEDV0amBEh7A3BOassb43ggpF/dr6JnjHGteI2QUsfwGMQgIfZ+egzDho/tSB1cI+UUvt5Elk=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr12440065pfj.130.1585573902959;
 Mon, 30 Mar 2020 06:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com> <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com> <20200330095707.GA10432@bogus> <0a374eaa-92b3-0201-f357-4181542c98b6@arm.com>
In-Reply-To: <0a374eaa-92b3-0201-f357-4181542c98b6@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 16:11:35 +0300
Message-ID: <CAHp75VdBm8ZYOMWmQEA8LD6uGcJ0sZ=M6n3MSYxmO6UkXbu+-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 3:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-03-30 11:13 am, Sudeep Holla wrote:
> > On Fri, Mar 27, 2020 at 07:40:25PM +0000, Robin Murphy wrote:

...

> AFAICS the difference is down to whether deferred_probe_timeout has
> expired or not - I'm not familiar enough with this code to know
> *exactly* what the difference is supposed to represent, nor which change
> has actually pushed the Juno case from one state to the other (other
> than it almost certainly can't be $SUBJECT - if this series is to blame
> at all I'd assume it would be down to patch #1/3, but there's a bunch of
> other rework previously queued in -next that is probably also interacting)

JFYI: patch #1/3 wasn't applied.


-- 
With Best Regards,
Andy Shevchenko
