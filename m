Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447F257488
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 00:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFZWtK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 18:49:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41491 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfFZWtK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 18:49:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so84291oia.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0kP6eyZ5Tl3qjozgE4k99bkRxQJ3H09e9k9c5FyUWQ=;
        b=Tw/gev90iyMsc/dD5bpBpfe6EbDeuQxWxztgIG1Tb0wvkgNK5zj66ER2rhFYtEbxiO
         ShXF7vBXsz61cy5UGxfGLTeF/jDqCW2uf2qhX4bW0mK7ocWgq5Y9Fs1RCDllx5yiLKP9
         xc411xHAStEVucb+J3FgI1sIEsS66my+EwH/qJIyasK57+GBEKfJYp7I8IOMy03vMelw
         PgMBwf3I6nAVD4Jfq6Igz6lM0TzZAwMU0KU6ROsQqd8kCaC/xO0ndSkm7hpG5/MjIfKb
         yvUrNFU/uaK4p25k85X9Fzce/IY57/WjHzzKten4XsXBCYpFdGmhTIP3Cm0PM7i4CS73
         iKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0kP6eyZ5Tl3qjozgE4k99bkRxQJ3H09e9k9c5FyUWQ=;
        b=LnkNS4KvU/Z5Z94vWUoHbTxEFs3EnSWNiKqfbPGaemg3TtWjMs5NOpguKRWQLCHdAv
         wQCTZCukAhXgKw+VhxgiX88XB6/Of/EW0D2MWGKWhqzyjqCagw+FNSn7CvqieCugja/h
         R5jXUiGNMcAJHaIwM9vr5B+LDQECh2SI1kpH6cB6faJlWEHHmWm7onX+ZWMbuJ/K7hxk
         4l6IDh/Uei+4wHpbZOZ5Xcld0smL+G+jvvGU1lzYF9TGoW+fkprYYbntZOdP4ybL2UQL
         bDCgv957ESIW0kb5Ka9S+UTQE2Jgwmr8J2nhL1lJIi0033vBBfJGB3MuUi0byLV21gSl
         Ry4g==
X-Gm-Message-State: APjAAAWGQmrZpGOIMzUI4CPuXo2qWf5omEuwnln7ZPudHYIXOHO6yotD
        0Oa3Vshz3X1W0oW9fRdxGWgSJk+G/l8jsQVfwSCRbQ==
X-Google-Smtp-Source: APXvYqzI32LHQAFCU9npXcsvYo7m4WBrpQOfpOG3SMIRkj+jxIfMrh3RSnLB/Bz/rHPQilhrdSnxafPmLUuOTPKrY8s=
X-Received: by 2002:aca:af55:: with SMTP id y82mr463012oie.172.1561589349384;
 Wed, 26 Jun 2019 15:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com> <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
In-Reply-To: <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 26 Jun 2019 15:48:58 -0700
Message-ID: <CANA+-vD+qBqENZrk_7KZzedbzGPMzHniHTE4sY93gnkzzBif6A@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 25, 2019 at 6:33 PM Tri Vo <trong@android.com> wrote:
>
> On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> > > Embedding a struct kobject into struct wakeup_source changes lifetime
> > > requirements on the latter. To that end, change deallocation of struct
> > > wakeup_source using kfree to kobject_put().
> >
> > Ick, are you sure you need a new kobject here?  Why wouldn't a named
> > attribute group work instead?  That should keep this patch much smaller
> > and simpler.
>
> Yeah, named attribute groups might be a much cleaner way to do this.
> Let me investigate.

Say, we read /sys/power/wakeup_sources/foo/active_count. This
attribute's show function needs to find wakeup_source struct of "foo".
I'm not sure how to do that without embedding a kobject inside of
wakeup_source.
